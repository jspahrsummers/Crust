//
//  Model.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-23.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

protocol Model: Equatable {
	class func properties() -> Property[]
	var _propertyStorage: Dictionary<String, protocol<Equatable>> { get set }
}

func getProperty<M: Model, T, P: Property where P.Value == T>(model: M, property: P) -> T? {
	assert(contains(_reify(model.dynamicType.properties()), PropertyOf(property)))

	return model._propertyStorage[property.key] as T?
}

func setProperty<M: Model, T: Equatable, P: Property where P.Value == T>(inout model: M, property: P, toValue: T) {
	assert(contains(_reify(model.dynamicType.properties()), PropertyOf(property)))

	model._propertyStorage[property.key] = toValue
}

struct TestModel: Model {
	static let name = PropertyOf<String>("name")
	static let createdAt = PropertyOf<NSDate>("createdAt")

	static func properties() -> Property[] {
		return [name, createdAt]
	}

	var _propertyStorage = Dictionary<String, protocol<Equatable>>()

	mutating func testThings() {
		getProperty(self, TestModel.name)
		setProperty(&self, TestModel.name, "foobar")
	}
}

@infix
func ==(lhs: TestModel, rhs: TestModel) -> Bool {
	return lhs._propertyStorage == rhs._propertyStorage
}
