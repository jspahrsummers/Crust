//
//  Property.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-22.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Describes a property's key and type.
protocol Property: Equatable, Hashable {
	typealias Value

	var key: String { get }
	var type: Any.Type { get }
}

/// Describes a property of type T.
struct PropertyOf<T>: Property {
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

	init(_ property: Property) {
		key = property.key
		type = property.type
	}
}

@infix
func ==<T>(lhs: PropertyOf<T>, rhs: PropertyOf<T>) -> Bool {
	return lhs.key == rhs.key
}

func _propertyArray(tuple: (Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0)]
}

func _propertyArray(tuple: (Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1)]
}

func _propertyArray(tuple: (Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2)]
}

func _propertyArray(tuple: (Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13), PropertyOf(tuple.14)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13), PropertyOf(tuple.14), PropertyOf(tuple.15)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13), PropertyOf(tuple.14), PropertyOf(tuple.15), PropertyOf(tuple.16)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13), PropertyOf(tuple.14), PropertyOf(tuple.15), PropertyOf(tuple.16), PropertyOf(tuple.17)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13), PropertyOf(tuple.14), PropertyOf(tuple.15), PropertyOf(tuple.16), PropertyOf(tuple.17), PropertyOf(tuple.18)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13), PropertyOf(tuple.14), PropertyOf(tuple.15), PropertyOf(tuple.16), PropertyOf(tuple.17), PropertyOf(tuple.18), PropertyOf(tuple.19)]
}

func _propertyArray(tuple: (Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property, Property)) -> PropertyOf<Any>[] {
	return [PropertyOf(tuple.0), PropertyOf(tuple.1), PropertyOf(tuple.2), PropertyOf(tuple.3), PropertyOf(tuple.4), PropertyOf(tuple.5), PropertyOf(tuple.6), PropertyOf(tuple.7), PropertyOf(tuple.8), PropertyOf(tuple.9), PropertyOf(tuple.10), PropertyOf(tuple.11), PropertyOf(tuple.12), PropertyOf(tuple.13), PropertyOf(tuple.14), PropertyOf(tuple.15), PropertyOf(tuple.16), PropertyOf(tuple.17), PropertyOf(tuple.18), PropertyOf(tuple.19), PropertyOf(tuple.20)]
}
