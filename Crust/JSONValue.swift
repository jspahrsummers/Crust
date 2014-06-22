//
//  JSONValue.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-21.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Represents a JSON value.
enum JSONValue {
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

	/// Attempts to parse a `JSONValue` from a data buffer.
	static func fromData(data: NSData, options: NSJSONReadingOptions = NSJSONReadingOptions()) -> Result<JSONValue> {
		var error: NSError?
		let maybeObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: options, error: &error)

		if let obj: AnyObject = maybeObj {
			return fromObject(obj)
		} else {
			return .error(error!)
		}
	}
	
	/// Attempts to parse a `JSONValue` from an input stream.
	static func fromStream(stream: NSInputStream, options: NSJSONReadingOptions = NSJSONReadingOptions()) -> Result<JSONValue> {
		var error: NSError?
		let maybeObj: AnyObject? = NSJSONSerialization.JSONObjectWithStream(stream, options: options, error: &error)

		if let obj: AnyObject = maybeObj {
			return fromObject(obj)
		} else {
			return .error(error!)
		}
	}
}
