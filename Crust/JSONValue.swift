//
//  JSONValue.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-21.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Represents a JSON value.
enum JSONValue: Equatable {
	case object(Dictionary<String, JSONValue>)
	case array(Array<JSONValue>)
	case string(String)
	case number(NSNumber)
	case boolean(Bool)
	case null

	/// Converts a dynamically-typed Objective-C object (such as you might get
	/// back from `NSJSONSerialization`) into a `JSONValue`.
	static func fromObject(obj: AnyObject) -> Result<JSONValue> {
		if let d = obj as? Dictionary<String, AnyObject> {
			var verifiedDictionary = Dictionary<String, JSONValue>()

			for (key, value: AnyObject) in d {
				switch fromObject(value) {
				case let .success(newValue):
					verifiedDictionary[key] = newValue
				
				case let .error(error):
					return .error(error)
				}
			}

			return .success(Box(object(verifiedDictionary)))
		} else if let a = obj as? Array<AnyObject> {
			var verifiedArray = Array<JSONValue>()

			for (value: AnyObject) in a {
				switch fromObject(value) {
				case let .success(newValue):
					verifiedArray.append(newValue)
				
				case let .error(error):
					return .error(error)
				}
			}

			return .success(Box(array(verifiedArray)))
		} else if let s = obj as? String {
			return .success(Box(string(s)))
		} else if obj === kCFBooleanTrue {
			return .success(Box(boolean(true)))
		} else if obj === kCFBooleanFalse {
			return .success(Box(boolean(false)))
		} else if let n = obj as? NSNumber {
			return .success(Box(number(n)))
		} else if obj is NSNull {
			return .success(Box(null))
		} else {
			// TODO: Use a real error here.
			return .error(nil)
		}
	}

	/// Converts a `JSONValue` into a dynamically-typed Objective-C object (such
	/// as you might pass into `NSJSONSerialization`).
	func toObject() -> AnyObject {
		switch self {
		case let .object(dict):
			var duckDictionary = NSMutableDictionary(capacity: dict.count)

			for (key, value) in dict {
				duckDictionary[key] = value.toObject()
			}

			return duckDictionary

		case let .array(arr):
			return arr.map { $0.toObject() }

		case let .string(str):
			return str
		
		case let .number(num):
			return num
		
		case let .boolean(b):
			if b {
				return kCFBooleanTrue
			} else {
				return kCFBooleanFalse
			}
		
		case let .null:
			return NSNull()
		}
	}

	/// Attempts to parse a `JSONValue` from a data buffer.
	static func fromData(data: NSData, options: NSJSONReadingOptions = NSJSONReadingOptions()) -> Result<JSONValue> {
		var error: NSError?
		let maybeObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: options, error: &error)

		if let obj: AnyObject = maybeObj {
			return fromObject(obj)
		} else {
			return .error(error)
		}
	}
	
	/// Attempts to parse a `JSONValue` from an input stream.
	static func fromStream(stream: NSInputStream, options: NSJSONReadingOptions = NSJSONReadingOptions()) -> Result<JSONValue> {
		var error: NSError?
		let maybeObj: AnyObject? = NSJSONSerialization.JSONObjectWithStream(stream, options: options, error: &error)

		if let obj: AnyObject = maybeObj {
			return fromObject(obj)
		} else {
			return .error(error)
		}
	}

	/// Attempts to serialize the JSON value to a data buffer.
	func toData(options: NSJSONWritingOptions = NSJSONWritingOptions()) -> Result<NSData> {
		var error: NSError?
		let maybeData = NSJSONSerialization.dataWithJSONObject(self.toObject(), options: options, error: &error)

		if let data = maybeData {
			return .success(Box(data))
		} else {
			return .error(error)
		}
	}

	/// Attempts to serialize the JSON value, then write it to an output stream.
	func toStream(stream: NSOutputStream, options: NSJSONWritingOptions = NSJSONWritingOptions()) -> Result<Int> {
		var error: NSError?
		let bytes = NSJSONSerialization.writeJSONObject(self.toObject(), toStream: stream, options: options, error: &error)

		if bytes > 0 {
			return .success(Box(bytes))
		} else {
			return .error(error)
		}
	}
}

@infix
func ==(lhs: JSONValue, rhs: JSONValue) -> Bool {
	switch lhs {
	case let .object(left):
		switch rhs {
		case let .object(right):
			return left == right

		default:
			return false
		}

	case let .array(left):
		switch rhs {
		case let .array(right):
			return left == right

		default:
			return false
		}

	case let .string(left):
		switch rhs {
		case let .string(right):
			return left == right

		default:
			return false
		}

	case let .number(left):
		switch rhs {
		case let .number(right):
			return left == right

		default:
			return false
		}

	case let .boolean(left):
		switch rhs {
		case let .boolean(right):
			return left == right

		default:
			return false
		}

	case let .null:
		switch rhs {
		case let .null:
			return true

		default:
			return false
		}

	}
}
