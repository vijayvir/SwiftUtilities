//
//  LeoRegex.swift
//  LeoContractBook
//
//  Created by vijay vir on 10/30/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//
//http://en.swifter.tips/regex/
//https://github.com/apple/swift-evolution/blob/master/proposals/0077-operator-precedence.md
//https://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149

import Foundation
precedencegroup ComparisonPrecedence {
	associativity: none
	higherThan: LogicalConjunctionPrecedence
}

infix operator =^ : ComparisonPrecedence

struct LeoRegex {
	enum LeoRegexType {
    case email
    case userName
    case password
    case hexValue
		case url
		case ipAddress
		case phoneNumberUSA
		case other
		case alphabets

		var pattern : String {
			switch self {
			case  .email:
				return "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
			case .userName:
				return "^[a-z0-9_-]{3,16}$"
			case .password:
				return "^[a-z0-9_-]{6,18}$"
			case .hexValue:
				return "^#?([a-f0-9]{6}|[a-f0-9]{3})$"
			case.phoneNumberUSA:
				 return "^(?\\d{3})?\\s\\d{3}-\\d{4}$"
			case .url:
				return ""
			case .ipAddress:
				return ""
			case .alphabets:
				return "^[a-z]{1,}$"
			default:
				return ""
			}
		}

	}

	let regex: NSRegularExpression?
	init(_ pattern: String) {
		regex =  try? NSRegularExpression(pattern: pattern ,
		                            options: [.caseInsensitive])
	}
	func match(input: String) -> Bool {
		if let matches = regex?.matches(in: input, options:
			[], range: NSMakeRange(0, input.count))  {

			return matches.count > 0

		} else {
			return false
		}
	}
}

func =^(lhs: String, rhs: String) -> Bool {
	return LeoRegex(rhs).match(input: lhs)
}
