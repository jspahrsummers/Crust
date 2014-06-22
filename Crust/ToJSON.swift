//
//  ToJSON.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-21.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Represents a type that can be encoded into JSON.
protocol ToJSON {
	func toJSON() -> JSONValue
}

extension JSONValue: ToJSON {
	func toJSON() -> JSONValue {
		return self
	}
}
