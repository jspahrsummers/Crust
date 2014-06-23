//
//  TestModel.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-23.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

protocol Property {
	class func type() -> Any.Type
}

class PropertyOf<T>: Property {
	var _closure: () -> T

	var value: T {
		get {
			return _closure()
		}

		set(newValue) {
			_closure = { newValue }
		}
	}

	init(_ value: T) {
		_closure = { value }
	}

	@conversion
	func __conversion() -> T {
		return _closure()
	}

	class func type() -> Any.Type {
		return T.self
	}
}

struct TestModel {
	typealias name = PropertyOf<String>

	var _name: name

	static let properties = (name.self.type())
}
