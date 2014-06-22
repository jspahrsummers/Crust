//
//  JSONValue.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-21.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Represents a JSON value.
enum JSONValue {
	case object(Dictionary<String, JSONValue>)
	case array(Array<JSONValue>)
	case string(String)
	case number(NSNumber)
	case boolean(Bool)
	case null
}
