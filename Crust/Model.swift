//
//  Model.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-23.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Describes a property's key and type.
protocol PropertyDescription: Equatable, Hashable {
	typealias Value

	var key: String { get }
	var type: Any.Type { get }
}

/// Describes a property of type T.
struct PropertyOf<T>: PropertyDescription {
	typealias Value = T

	let key: String
	let type: Any.Type = T.self
	
	var hashValue: Int {
		get {
			return key.hashValue
		}
	}

	init(_ key: String) {
		self.key = key
	}

	init(_ property: PropertyDescription) {
		key = property.key
		type = property.type
	}
}

@infix
func ==<T>(lhs: PropertyOf<T>, rhs: PropertyOf<T>) -> Bool {
	return lhs.key == rhs.key
}

func _reify(properties: PropertyDescription[]) -> PropertyOf<Any>[] {
	return properties.map { PropertyOf<Any>($0) }
}

/// The type of dictionary that should be used to store a Model's backing
/// properties.
typealias PropertyStorage = Dictionary<String, protocol<Equatable>>

/// Represents a model object with dynamic property storage.
///
/// This should typically be a value type.
protocol Model {
	class func describe() -> PropertyDescription[]
	var properties: PropertyStorage { get set }

	init(properties: PropertyStorage)
}

/// Gets the value of the given property from the given model.
func getProperty<M: Model, T: Equatable, P: PropertyDescription where P.Value == T>(model: M, property: P) -> T? {
	assert(contains(_reify(model.dynamicType.describe()), PropertyOf(property)))

	return model.properties[property.key] as T?
}

/// Instantiates a new model that will have the given property set to the given
/// new value.
func transformProperty<M: Model, T: Equatable, P: PropertyDescription where P.Value == T>(model: M, property: P, value: T) -> M? {
	assert(contains(_reify(model.dynamicType.describe()), PropertyOf(property)))

	var properties = model.properties
	properties[property.key] = value

	return model.dynamicType(properties: properties)
}

/// Sets the value of the given property on the given model.
func setProperty<M: Model, T: Equatable, P: PropertyDescription where P.Value == T>(inout model: M, property: P, toValue: T) {
	assert(contains(_reify(model.dynamicType.describe()), PropertyOf(property)))

	model.properties[property.key] = toValue
}

/// Clears any existing value for the given property on the given model.
func clearProperty<M: Model>(inout model: M, property: PropertyDescription) {
	assert(contains(_reify(model.dynamicType.describe()), PropertyOf(property)))

	model.properties.removeValueForKey(property.key)
}

struct TestModel: Model {
	static let name = PropertyOf<String>("name")
	static let createdAt = PropertyOf<NSDate>("createdAt")

	static func describe() -> PropertyDescription[] {
		return [name, createdAt]
	}

	var properties: PropertyStorage

	mutating func testThings() {
		getProperty(self, TestModel.name)
		setProperty(&self, TestModel.name, "foobar")
	}
}

@infix
func ==(lhs: TestModel, rhs: TestModel) -> Bool {
	return lhs.properties == rhs.properties
}
