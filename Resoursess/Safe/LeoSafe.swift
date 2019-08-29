//
//  LeoSafe.swift
//  Hive
//
//  Created by Nitish Sharma on 13/09/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit
//
//  LeoExtString.swift
//  Extentions
//
//  Created by vijay vir on 9/8/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import Foundation
//https://medium.com/ios-os-x-development/handling-empty-optional-strings-in-swift-ba77ef627d74
// MARK: String
extension String {
    var leoLog : String {
        
        #if DEBUG
        Swift.print(self)
        #else
        
        #endif
        
        
        
        
        return self
    }
}
extension Dictionary   where Key: ExpressibleByStringLiteral, Value: Any  {
    var leoLog : [String  : Any] {
        #if DEBUG
        Swift.print(self)
        #else
        #endif
        return self as! [String : Any]
    }
}


extension Optional where Wrapped == String {
    func leoSafe(defaultValue : String? = "") -> String {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf.isEmpty ? defaultValue! : strongSelf
    }
}
// MARK: Int
extension Optional where Wrapped == Int {
    
    func leoSafe(defaultValue : Int? = 0 ) -> Int {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf
    }
}

extension Optional where Wrapped == Double {
    
    func leoSafe(defaultValue : Double? = 0 ) -> Double {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf
    }
}

// MARK: BOOL
extension Optional where Wrapped == Bool {
    
    func leoSafe(defaultValue : Bool? = false ) -> Bool {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf
    }
}
// MARK: Date
extension Optional where Wrapped == Date {
    
    func leoSafe(defaultValue : Date? = Date() ) -> Date {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf
    }
}


extension Int {
    var leoString : String {
        return "\(self)"
    }
    
    var leoBool: Bool {
        if self == 0 {
            return false
        }
        return true
    }
}
extension String {
    var leoInt : Int {
        return Int(self) ?? 0
    }
    var leoFloat : Float {
        return Float(self) ?? 0
    }
    var leoIgnore : String {
        return ""
    }
}

//extension Optional  where Wrapped == [[String : Any]]{
//    func leoSafe (defaultValue : [[String : Any]]? = [] ) -> [[String : Any]] {
//        guard let strongSelf = self else {
//            return defaultValue!
//        }
//        return strongSelf
//    }
//}

// MARK: Array<Dictionary<String, Any>>

extension Optional  where Wrapped == Array<Dictionary<String, Any>>{
    func leoSafe (defaultValue : Array<Dictionary<String, Any>>? = [] ) -> Array<Dictionary<String, Any>> {
        guard let strongSelf = self else {
            return defaultValue!
        }
        return strongSelf
    }
}
// MARK: Array<String>
extension Optional  where Wrapped == Array<String>{
    func leoSafe (defaultValue : Array<String>? = [] ) -> Array<String> {
        guard let strongSelf = self else {
            return defaultValue!
        }
        return strongSelf
    }
}
// MARK:  Array<Int>
extension Optional  where Wrapped == Array<Int>{
    func leoSafe (defaultValue : Array<Int>? = [] ) -> Array<Int> {
        guard let strongSelf = self else {
            return defaultValue!
        }
        return strongSelf
    }
}

// MARK:  Array<Bool>
extension Optional  where Wrapped == Array<Bool>{
    func leoSafe (defaultValue : Array<Bool>? = [] ) -> Array<Bool> {
        guard let strongSelf = self else {
            return defaultValue!
        }
        return strongSelf
    }
}

// MARK:  Array<Float>
extension Optional  where Wrapped == Array<Float>{
    func leoSafe (defaultValue : Array<Float>? = [] ) -> Array<Float> {
        guard let strongSelf = self else {
            return defaultValue!
        }
        return strongSelf
    }
}
// MARK:  Array<Double>
extension Optional  where Wrapped == Array<Double>{
    func leoSafe (defaultValue : Array<Double>? = [] ) -> Array<Double> {
        guard let strongSelf = self else {
            return defaultValue!
        }
        return strongSelf
    }
}
// MARK:  Array<Any>
extension Optional  where Wrapped == Array<Any>{
    func leoSafe (defaultValue : Array<Any>? = [] ) -> Array<Any> {
        guard let strongSelf = self else {
            return defaultValue!
        }
        return strongSelf
    }
}

extension Optional  {
    func leoNil(_ callback : ((Wrapped)-> Void)? = nil  ) {
        if self != nil {
            callback?(self!)
        }
    }
    
}


//extension Optional  where Wrapped == Sequence {
//    func leoSafe <T> (defaultValue : [T]? = [] ) -> [T] {
//        guard let strongSelf = self else {
//            return defaultValue!
//        }
//        return strongSelf as! [T]
//    }
//}
