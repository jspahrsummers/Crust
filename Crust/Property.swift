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

func _reify(properties: Property[]) -> PropertyOf<Any>[] {
	return properties.map { PropertyOf<Any>($0) }
}
