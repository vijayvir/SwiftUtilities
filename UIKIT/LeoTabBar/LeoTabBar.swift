//
//  SivTabButtonO.swift
//  SmartItVenturesLogInOut
//
//  Created by Anupriya on 16/09/17.
//  Copyright © 2017 Anupriya. All rights reserved.
//

import UIKit

import IBAnimatable

class TabButton: UIButton {
    
    @IBInspectable var selectedColor  : UIColor = #colorLiteral(red: 0.9994125962, green: 0.4018217623, blue: 0, alpha: 1)
    
    @IBInspectable  var color  : UIColor = #colorLiteral(red: 0.9994125962, green: 0.4018217623, blue: 0, alpha: 1)
    
    @IBInspectable var  selectedImage : UIImage =  #imageLiteral(resourceName: "green_call_icon")
    
    @IBInspectable var  deSelectedImage : UIImage = #imageLiteral(resourceName: "green_call_icon")
    
    @IBOutlet weak var imgvIcon: UIImageView!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var viewBackBround: AnimatableView!
    
    @IBOutlet weak var viewContiner: UIView?
    
    override var isSelected: Bool {
        
        willSet {
            
        }
        
        /*
         case shake(repeatCount: Int)
         case pop(repeatCount: Int)
         case squash(repeatCount: Int)
         case flip(along: Axis)
         case morph(repeatCount: Int)
         case flash(repeatCount: Int)
         case wobble(repeatCount: Int)
         case swing(repeatCount: Int)
         public enum Axis: String {
         case x, y
         }
         */
        
        didSet {
            
            if isSelected {
                
                imgvIcon.image = #imageLiteral(resourceName: "green_call_icon")
                
                lbltitle.textColor = selectedColor
                viewContiner?.isHidden = false
                viewBackBround.animate(AnimationType.swing(repeatCount: 1))
                
            } else {
                
                imgvIcon.image = #imageLiteral(resourceName: "green_call_icon")
                lbltitle.textColor =  color
                viewContiner?.isHidden = true
            }
            
        }
    }
    
}


