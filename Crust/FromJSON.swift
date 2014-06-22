//
//  FromJSON.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-21.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Represents a type that can be decoded from JSON.
protocol FromJSON {
	class func fromJSON(value: JSONValue) -> Result<Self>
}

extension JSONValue: FromJSON {
	static func fromJSON(value: JSONValue) -> Result<JSONValue> {
		return .success(Box(value))
	}
}
