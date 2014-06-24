//
//  Model.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-23.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// The type of dictionary that should be used to store a Model's backing
/// properties.
typealias PropertyStorage = Dictionary<String, protocol<Equatable>>

/// Represents a model object with dynamic property storage.
///
/// This should typically be a value type.
protocol Model: Equatable {
	class func properties() -> Property[]
	var _propertyStorage: PropertyStorage { get set }
}

/// Gets the value of the given property from the given model.
func getProperty<M: Model, T, P: Property where P.Value == T>(model: M, property: P) -> T? {
	assert(contains(_reify(model.dynamicType.properties()), PropertyOf(property)))

	return model._propertyStorage[property.key] as T?
}

/// Sets the value of the given property on the given model.
func setProperty<M: Model, T: Equatable, P: Property where P.Value == T>(inout model: M, property: P, toValue: T) {
	assert(contains(_reify(model.dynamicType.properties()), PropertyOf(property)))

	model._propertyStorage[property.key] = toValue
}

/// Clears any existing value for the given property on the given model.
func clearProperty<M: Model>(inout model: M, property: Property) {
	assert(contains(_reify(model.dynamicType.properties()), PropertyOf(property)))

	model._propertyStorage.removeValueForKey(property.key)
}

struct TestModel: Model {
	static let name = PropertyOf<String>("name")
	static let createdAt = PropertyOf<NSDate>("createdAt")

	static func properties() -> Property[] {
		return [name, createdAt]
	}

	var _propertyStorage = PropertyStorage()

	mutating func testThings() {
		getProperty(self, TestModel.name)
		setProperty(&self, TestModel.name, "foobar")
	}
}

@infix
func ==(lhs: TestModel, rhs: TestModel) -> Bool {
	return lhs._propertyStorage == rhs._propertyStorage
}
