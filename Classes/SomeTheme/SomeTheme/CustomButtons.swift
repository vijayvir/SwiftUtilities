//
//  CustomButtons.swift
//  HelloDamage
//
//  Created by tecH on 26/03/19.
//  Copyright © 2019 Ravinder Kumar. All rights reserved.
//

import UIKit

enum ThArrowButtonType : Int  {
    case clould = 1
    case setting = 2
    case Phone = 3
    
 
    
}




@IBDesignable
class CustomButtons: UIButton {
 @IBInspectable  var type: Int = ThArrowButtonType.clould.rawValue
    var number : Int =  0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        
        if type == ThArrowButtonType.clould.rawValue {
            self.setImage(  StyleKit.imageOfCanvasClould(records: CGFloat(number)), for: .normal)
        } else  if type == ThArrowButtonType.setting.rawValue {
            
            self.setImage(  StyleKit.imageOfCanvasSetting, for: .normal)
        }
        
}
}

