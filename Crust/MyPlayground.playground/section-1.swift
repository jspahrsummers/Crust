// Playground - noun: a place where people can play

import Cocoa

protocol Property {
	typealias Value

	var type: Any.Type { get }
}

class PropertyOf<T>: Property {
	typealias Value = T
	let name: String
	let type: Any.Type = T.self

	init(_ name: String) {
		self.name = name
	}

	func construct() -> ConstructedProperty<T> {
		return ConstructedProperty()
	}
}

struct TestModel {
	class name: PropertyOf<String> {}
}

let p: Property = PropertyOf<Int>("foobar")

p.type is Int.Type