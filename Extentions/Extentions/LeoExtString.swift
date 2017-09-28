//
//  LeoExtString.swift
//  Extentions
//
//  Created by vijay vir on 9/8/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import Foundation

//https://medium.com/ios-os-x-development/handling-empty-optional-strings-in-swift-ba77ef627d74

extension Optional where Wrapped == String {

	var nilIfEmpty : String? {

		guard let strongSelf = self else {

			return nil

		}

		return strongSelf.isEmpty ? nil : strongSelf

	}

	func safe(defaultValue : String? = "") -> String? {

		guard let strongSelf = self else {

			return defaultValue

		}

		return strongSelf.isEmpty ? defaultValue : strongSelf
		
	}

}


