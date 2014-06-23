//
//  Property.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-22.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

protocol Property {
	typealias Value
}

class LeafProperty<P: Property, > {
	let type: Any.Type = P.Value
}

class ChainedProperty<P: Property, N>: LeafProperty<P> {
	let nextProperty: P

	init(_ nextProperty: P) {
		self.nextProperty = nextProperty
		super.init()
	}
}

func propertiesOf<A>(names: (A)) -> LeafProperty<A> {
	return LeafProperty()
}

func propertiesOf<A, B>(names: (String, String)) -> ChainedProperty<A, LeafProperty<B>> {
	return ChainedProperty(names.0, nextProperty: LeafProperty(names.1))
}

struct TestModel {
	static let name = PropertyOf<String>

	typealias 

	var name: String
	var createdAt: NSDate

	static let properties = (
		TestModel.self.name
	)
}

/*
func doThings() -> TestModel? {
	"foo" is TestModel.name.property.type
	return nil
}
*/
