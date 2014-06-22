//
//  Property.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-22.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

struct ConstructedProperty<T> {
	var value: T? = nil
}

protocol Property {
	typealias Value

	var name: String { get }
	func construct() -> ConstructedProperty<Value>
}

struct PropertyOf<T>: Property {
	typealias Value = T
	let name: String

	init(_ name: String) {
		self.name = name
	}

	func construct() -> ConstructedProperty<T> {
		return ConstructedProperty()
	}
}

func construct<A>(properties: (PropertyOf<A>)) -> (ConstructedProperty<A>) {
	return (properties.0.construct())
}

func construct<A, B>(properties: (PropertyOf<A>, PropertyOf<B>)) -> (ConstructedProperty<A>, ConstructedProperty<B>) {
	return (properties.0.construct(), properties.1.construct())
}

func collect<A>(properties: (PropertyOf<A>)) -> Property[] {
	return [properties.0]
}

func collect<A, B>(properties: (PropertyOf<A>, PropertyOf<B>)) -> Property[] {
	return [properties.0, properties.1]
}

struct TestModel {
	static let properties = (
		PropertyOf<String>("name"),
		PropertyOf<NSDate>("createdAt")
	)

	static func propertyNames() -> String[] {
		return collect(properties).map { $0.name }
	}

	var properties = construct(TestModel.properties)

	/*
	mutating func setValue<EV: TypeEquality where EV.From == Property, EV.To == name>(value: String, _ ev: EV) {
		_name.value = value
	}

	mutating func setValue<createdAt>(value: NSDate) {
		_createdAt.value = value
	}

	func getProperties() -> TypeEquality[] {
		return [ PropertyRefl<name>(), PropertyRefl<createdAt>() ]
	}
	*/
}
