//
//  LeoFont.swift
//  Created by tecH on 21/06/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit
extension UIFont {
    
    func withName (_ name : String) -> UIFont{
        return UIFont(name: name, size: self.pointSize) ?? UIFont()
    }
    
    func withSize (_ size : CGFloat) -> UIFont{
        return UIFont(name:  self.fontName, size: size) ?? UIFont()
    }
    
}


extension StringProtocol {
    var firstUppercasedLeoFont: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalizedLeoFont: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
    
    var unCapitalizedLeoFont: String {
        guard let first = first else { return "" }
        return String(first).lowercased() + dropFirst()
    }
}

extension UIFont {
    
    class func leoMakeFontNameEnums(_ name : String =  "LeoFontNames") {
        print("enum \(name)  {")
        
        UIFont.familyNames.forEach({ familyName in
            let some = familyName.replacingOccurrences(of: " ", with: "_")
            print("case \(some.unCapitalizedLeoFont)(\(some.firstUppercasedLeoFont))")
            
        })
        
        
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            
            let some = familyName.replacingOccurrences(of: " ", with: "_")
            
            print("  enum  \(some.firstCapitalizedLeoFont) : String {")
            
            
            if fontNames.count ==  0 {
                
                print("\t case \(some.unCapitalizedLeoFont) = \"\(familyName)\"")
                
                
                
            } else {
                for name in fontNames {
                    let nameAfter = name.replacingOccurrences(of: "-", with: "_")
                    print("\t case \(nameAfter.unCapitalizedLeoFont) = \"\(name)\"")
                }
            }
            
            print(" }")
            
        })
        
        
        print("}")
        
    }
    
}




