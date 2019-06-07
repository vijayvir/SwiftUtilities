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
//https://regexr.com/4f6q7
//https://medium.com/@abhimuralidharan/how-to-create-a-custom-operator-like-operator-in-swift-55953c0c0bf2
//https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift
/*
 \d means [0-9]
 [] only needed if you want to extract the matching parts
 ^[0-9]*[.]?[0-9]*$"
 ^ is start of operation
 $ is end of opration
 * means Zero or many
 ? means Zero or One
 */
import Foundation
precedencegroup ComparisonPrecedence {
    associativity: none
    higherThan: LogicalConjunctionPrecedence
}

infix operator =^ : ComparisonPrecedence  //// =^
infix operator =* : ComparisonPrecedence  //// =^
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
        case numberDecimal
        case custom(String)
        
        
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
            case .numberDecimal:
                return "^([0-9]+).([0-9]{0,})$" // ^[0-9]*[.]?[0-9]*$"
            case .other:
                return ""
            case .custom(let some ):
                return  some
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
            print(matches)
            return matches.count > 0
            
        } else {
            return false
        }
    }
}

func =^(lhs: String, rhs: String) -> Bool {
    return LeoRegex(rhs).match(input: lhs)
}
func =*(lhs: String, rhs: LeoRegex.LeoRegexType) -> Bool {
    return LeoRegex(rhs.pattern).match(input: lhs)
}
