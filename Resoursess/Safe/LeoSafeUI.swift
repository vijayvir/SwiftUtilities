//
//  LeoSafeUI.swift
//  Hive
//
//  Created by Nitish Sharma on 05/10/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit
extension Optional where Wrapped ==  UIImage {
    
    func leoSafe(defaultValue : UIImage? = #imageLiteral(resourceName: "TemplateIcon1.png")) -> UIImage {
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return strongSelf
    }
    
}
extension Optional where Wrapped ==  UITextField {
    
    func leoSafe(defaultValue : Bool? = false ) -> Bool {
        
        guard let strongSelf = self else {
            return defaultValue!
        }
        
        return true
    }
    
}
