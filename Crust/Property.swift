//
//  Property.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-22.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

struct Property<T> {
	let name: String
	
	let _getter: () -> T
	let _setter: T -> ()

	var value: T {
		get {
			return _getter()
		}

		set(newValue) {
			_setter(newValue)
		}
	}

	init(name: String, inout value: T) {
		self.name = name
		_getter = { value }
		_setter = { value = $0 }
	}
}
