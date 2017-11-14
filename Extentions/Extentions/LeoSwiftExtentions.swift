//
//  LeoSwiftExtentions.swift
//  MyTaxiRide
//
//  Created by vijay vir on 5/30/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import Foundation
extension String {
	func leoSeperatedBy(word : String? = "," , getStringAt index : Int? = 0 ) -> String {
		let fullNameArr = self.components(separatedBy:word!)
		return fullNameArr[index!]

	}
	func beforeComma() -> String {
		let fullNameArr = self.components(separatedBy: ",")
		return fullNameArr[0]

	}
	func afterComma() -> String {
		let fullNameArr = self.components(separatedBy: ",")

		var address22 = ""

		for (index, addressTemp) in (fullNameArr.enumerated()) {

			let  address = 	addressTemp.trimmingCharacters(in: .whitespacesAndNewlines)

			if index == 0 {
				continue
			} else if index == 1 {
				address22 =  address
			} else {
				address22 +=  "," + address
			}

		}
		return address22

	}

	func random6DigitString() -> String {
		let min: UInt32 = 100_000
		let max: UInt32 = 999_999
		let i = min + arc4random_uniform(max - min + 1)
		return String(i)
	}

	enum Header: String {
		case http = "http://"

		case https = "https://"

	}

	func isValidForUrl() -> Bool {
		if self.hasPrefix("http") || self.hasPrefix("https") {
			return true
		}
		return false
	}

	func validUrl(header: Header) -> String {
		if !self.hasPrefix("http") {
			return header.rawValue + self
		} else {
			return self
		}

	}

}
