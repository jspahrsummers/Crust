//
//  Schema.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-22.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

protocol Introspectable {
	class var schema: Schema { get }
}

protocol Schema {
	typealias Owner

	var properties: Property[] { get }
}

struct SchemaOf<O>: Schema {
	typealias Owner = O

	let properties: Property[]

	init(properties: Property[]) {
		self.properties = properties
	}
}

protocol Property {
	typealias Owner
	typealias Value

	var type: Any.Type { get }

	func readFrom(owner: Owner) -> Value
	func write(value: Value, to: Owner)
}

struct PropertyOf<T, O>: Property {
	typealias Owner = O
	typealias Value = T

	let type: Any.Type = T.self
	let _read: O -> T
	let _write: (T, O) -> ()

	init(read: O -> T, write: (T, O) -> ()) {
		_read = read
		_write = write
	}

	func readFrom(owner: Owner) -> Value {
		return _read(owner)
	}

	func write(value: Value, to owner: Owner) {
		_write(value, owner)
	}
}

func propertyOf<O, T>(#read: O -> T, #write: (T, O) -> ()) -> PropertyOf<T, O> {
	return PropertyOf(read: read, write: write)
}

struct TestModel {
	var name: String

	let nameProperty = propertyOf(read: { $0.name }, write: { $0.name = $1 })
}
