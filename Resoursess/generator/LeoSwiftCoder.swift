//
//  LeoSwiftCoder.swift
//  Apex
//
//  Created by tecH on 05/02/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
extension StringProtocol {
    var firstUppercasedLSC : String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalizedLSC: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
    
    var unCapitalizedLSC: String {
        guard let first = first else { return "" }
        return String(first).lowercased() + dropFirst()
    }
}
class LeoSwiftCoder {
    
    func leoClassMake(withName : String , json :Any) {
        switch json.self {
        case is [String : Any] :
            
            if let someJson = json as? [String : Any] {
                print("class \(withName) {")
                print("var serverData : [String: Any] = [:]")
                for key in someJson.keys {
                    print( "var \(key.unCapitalizedLSC) : \(self.typeOf(send: someJson[key]! , key : key))?" )
                }
                print("init(dict: [String: Any]){")
                print(" self.serverData = dict \n ")
                for key in someJson.keys {
                    print( self.defineVariable(key :key , send: someJson[key]!) )
                    
                }
                print("}")
             
                for object in someJson.keys {
                    if let nextObject = someJson[object] as? [String : Any] {
                        self.leoClassMake(withName: object.capitalized, json: nextObject)
                    } else if let nextObject = someJson[object] as? [[String : Any]] {
                        if nextObject.count > 0 {
                            self.leoClassMake(withName: object.capitalized, json: nextObject.first!)
                        }
                    }else if let nextObject = someJson[object] as? Array<String> {
                        self.leoClassMake(withName: object.capitalized, json: nextObject)
                    }
                    
                }
                   print("}")
            }
            
        case is Array<String> :
           if let someJson = json as? [String] {
            if someJson.count > 0 {
                print("class \(withName) {")
                print("var serverData : String = \"\"")
                
                print("init(dict: String){")
                print(" self.serverData = dict \n ")
                
                
                print("}")
                print("}")
            }
           }
        
            
        case is Int :
            print("")
        case is Array<Any> :
            print("")
        case is Dictionary<String, Any> :
            print("")
        case is Bool :
            print("")
        case is String :
            print("")
            
        default:
            print("")
        }
        
    }
    
    private   func defineVariable(key :String, send :Any) -> String{
        switch send.self {
        case is [String : Any] :
            
            let some =  """
            if let object = dict[\"\(key)\"] as? [String : Any] {
            let some =  \(key.capitalized)(dict: object)
            self.\(key.unCapitalizedLSC) = some }
            """
            
            return  some
            
        //"if let \(key) = dict[\"\(key)\"] as? \(key.capitalized) { \n self.\(key) = \(key) \n }"
        case is [[String : Any]] :
            
            let some =  """
            if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? [[String : Any]] {
            self.\(key.unCapitalizedLSC) = []
            for object in \(key.unCapitalizedLSC) {
            let some =  \(key.capitalized)(dict: object)
            self.\(key.unCapitalizedLSC)?.append(some)
            
            }
            }
            """
            return  some
        case is Int :
            return "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? Int { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
            
        case is Double :
            return "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? Double { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
            
        case is Array<String>  :
            
            let some =  """
            if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? [[String]] {
            self.\(key.unCapitalizedLSC) = []
            
            if \(key.unCapitalizedLSC).count > 0 {
            for object in \(key.unCapitalizedLSC).first! {
            let some =  \(key.capitalized)(dict: object)
            self.\(key.unCapitalizedLSC)?.append(some)
            
            }
            }
            }
            """
            return  some
            
            
        case is Array<Any> :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? Array<Any> { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
        case is Dictionary<String, Any> :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as?  Dictionary<String, Any> { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
        case is Bool :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? Bool { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
        case is String :
            return  "if let \(key.unCapitalizedLSC) = dict[\"\(key)\"] as? String { \n self.\(key.unCapitalizedLSC) = \(key.unCapitalizedLSC) \n }"
            
        default:
            return "Any"
        }
    }
    private  func typeOf(send :Any , key : String? = nil ) -> String{
        switch send.self {
        case is [String : Any] :
            if (key != nil) {
                return "\(key!.capitalized)"
            } else {
                return "[String : Any]"
            }
        case is [[String : Any]] :
            if (key != nil) {
                return "[\(key!.capitalized)]"
            } else {
                return "[[String : Any]]"
            }
        case is Array<String> :
            if (key != nil) {
                return "[\(key!.capitalized)]"
            } else {
                return "[[String]]"
            }
            
        case is [[String]] :
            if (key != nil) {
                return "[\(key!.capitalized)]"
            } else {
                return "[[String]]"
            }
        case is Int :
            return "Int"
        case is Double :
            return "Double"
       
            
        case is Array<Any> :
            return "Array<Any>"
        case is Dictionary<String, Any> :
            return "Dictionary<String, Any>"
        case is Bool :
            return "Bool"
        case is String :
            return "String"
            
        default:
            return "Any"
        }
        
    }
    
}

