//
//  JSONAdapter.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-23.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// A model that can be mapped to and from JSON.
protocol JSONModel: Model {
	class func JSONMapping() -> Dictionary<String, PropertyDescription>
}

/// Wraps a model M for JSON serialization or deserialization.
struct JSONAdapter<M: JSONModel>: ToJSON, FromJSON {
	let model: M

	static func fromJSON(value: JSONValue) -> Result<JSONAdapter<M>> {
		return .error(nil)
	}

	func toJSON() -> JSONValue {
		return .null
	}
}
