//
//  TestModel.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-23.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

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
