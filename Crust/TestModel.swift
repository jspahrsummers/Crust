//
//  TestModel.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-23.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

struct TestModel {
	static let name = PropertyOf<String>("name")
	static let properties = (name)

	var _propertyStorage = Dictionary<String, Any>()

	func getProperty<T, P: Property where P.Value == T>(property: P) -> T? {
		assert(contains(_propertyArray(TestModel.properties), PropertyOf(property)))

		return _propertyStorage[property.key] as T?
	}

	mutating func setProperty<T, P: Property where P.Value == T>(property: P, toValue: T) {
		assert(contains(_propertyArray(TestModel.properties), PropertyOf(property)))

		_propertyStorage[property.key] = toValue
	}

	mutating func testThings() {
		getProperty(TestModel.name)
		setProperty(TestModel.name, toValue: "foobar")
	}
}
