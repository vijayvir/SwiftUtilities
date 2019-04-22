//
//  TextField.swift
//  Apex
//
//  Created by Nitish Sharma on 10/10/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//
import Foundation
import UIKit
import UserNotifications

extension UITextField {
    func placeholderColor( _ text : String? = "" ,   color :UIColor? = .gray  ) {
        self.placeholder = text
        self.attributedPlaceholder = NSAttributedString(string: text!,
                                                        attributes: [NSAttributedString.Key.foregroundColor:color!])
    }
}


extension UITextField {
    func isValidEmailAddress() -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self.text.leoSafe() as NSString
            let results = regex.matches(in: self.text.leoSafe(), range: NSRange(location: 0, length: nsString.length))
            if results.count == 0{
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    func lenght() -> Bool {
        if self.text.leoSafe().count <= 0 {
              return false
            }
            return true
        }
    
}
