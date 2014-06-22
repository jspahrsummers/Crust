//
//  Result.swift
//  Crust
//
//  Created by Justin Spahr-Summers on 2014-06-21.
//  Copyright (c) 2014 Justin Spahr-Summers. All rights reserved.
//

import Foundation

/// Represents the result of an operation which may produce a value of type T or
/// fail.
enum Result<T> {
	case error(NSError)
	case success(Box<T>)
}
