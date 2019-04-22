//
//  StructToJson.swift
//  MedicalApp
//
//  Created by Apple on 12/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import Foundation
import UIKit

protocol LeoJsonRepresentable {
    var jsonStruct: Any {
        get
    }
}

protocol LeoSerializable: LeoJsonRepresentable {
    
}

func LeoDiscription( object : Any) -> [String : Any]{
    var representation = [String: Any]()
    for case let (variableName?, variableValue) in Mirror(reflecting: object).children {
        switch variableValue {
        case let value :
            if let some =  Mirror(reflecting: value).displayStyle as? Swift.Mirror.DisplayStyle {
                switch some {
                case .struct:
                    representation[variableName] =  LeoDiscription(object: value)
                case .class:
                    representation[variableName] =  LeoDiscription(object: value)
                case .enum:
                    print("enum")
                case .tuple:
                    print("tuple")
                case .optional:
                    print("optional")
                case .collection:
                    representation[variableName] = value
                case .dictionary:
                    representation[variableName] = value
                case .set:
                    print("set")
                }
                
            }else {
                representation[variableName] = value
            }
            
            
            
        }
    }
    return representation
}

extension LeoSerializable {
    var jsonStruct: Any {
        var representation = [String: Any]()
        for case let (variableName?, variableValue) in Mirror(reflecting: self).children {
            switch variableValue {
            case let value as LeoJsonRepresentable:
                representation[variableName] = value.jsonStruct
                
            case let value :
                if let some =  Mirror(reflecting: value).displayStyle as? Swift.Mirror.DisplayStyle {
                    
                    switch some {
                        
                    case .struct:
                        representation[variableName] =  LeoDiscription(object: value)
                        //representation[variableName] = value.jsonStruct
                        
                        
                    case .class:
                        representation[variableName] =  LeoDiscription(object: value)
                    case .enum:
                        print("enum")
                    case .tuple:
                        print("tuple")
                    case .optional:
                        print("optional")
                    case .collection:
                        representation[variableName] = value
                    case .dictionary:
                        representation[variableName] = value
                    case .set:
                        print("set")
                    }
                    
                }else {
                    representation[variableName] = value
                }
                
                
                
            }
        }
        
        return representation as AnyObject
    }
    
    func toJsonObect() -> Any {
        if  let jsonString = self.toJsonString() {
            let data: NSData = jsonString.data(using: String.Encoding.utf8)! as NSData
            
            do {
                if let dictionaryOK = try JSONSerialization.jsonObject(with: data as Data, options: []) as? Any {
                    return dictionaryOK
                }
            } catch {
                print(error)
            }
        }
        return "not a proper Json" as Any
    }
    
    func toJsonString() -> String? {
        guard JSONSerialization.isValidJSONObject(jsonStruct) else {
            print("not a proper Json")
            return nil
        }
        
        do {
            
            let data = try JSONSerialization.data(withJSONObject: jsonStruct, options: [])
            
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
    
    func toEncodingURLStr() -> String? {
        if let jsonObject = self.toJsonObect() as? [String: Any] {
            
            let strEnove = jsonObject.map { $0.key + "=" + ("\($0.value)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed))! }
            
            let some = strEnove.reduce("") { $0.isEmpty ? $1 : $0 + "&" + $1 }
            
            return some
        } else  {
            return ""
        }
        
        
        
    }
    
}

extension Date: LeoSerializable {
    
    var jsonStruct: AnyObject {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter.string(from: self) as AnyObject
    }
    
}

/*
 
 struct  Family : StructJSONSerializable
 {
 var mother: String
 var father: String
 }
 
 struct Owner : StructJSONSerializable
 {
 var name: String
 var timestamp: Date
 var phoneNumbers : [String]
 var dob : [String : String]
 
 -> var family: Family
 
 }
 
 struct Car: StructJSONSerializable
 {
 var manufacturer: String
 var model: String
 var mileage: Float
 
 -> var owner: Owner
 
 }
 
 var car = Car(
 manufacturer: "Tesla", model: "Model T",
 mileage: 1234.56,
 owner: Owner(
 name: "Emial" ,
 timestamp: Date(),
 phoneNumbers : ["7896544","45632178"] ,
 dob :  ["month":"11" , "date":"30 " ],
 family :Family(mother: "Dad", father: "Mom")
 )
 )
 
 car.model = "Maruti"
 
 if let json   = car.toJsonString()
 {
 print(car)
 // print("asdd", type(of: json) , json)
 
 }
 
 */
