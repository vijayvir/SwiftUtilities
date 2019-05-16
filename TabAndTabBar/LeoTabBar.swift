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
    @IBInspectable var normalBorderColor  : UIColor = #colorLiteral(red: 0.2945333719, green: 0.2947671115, blue: 0.2988897562, alpha: 1)
    
    @IBInspectable  var color  : UIColor = #colorLiteral(red: 0.9994125962, green: 0.4018217623, blue: 0, alpha: 1)
    
    @IBInspectable var  selectedImage : UIImage =  #imageLiteral(resourceName: "back")
    @IBInspectable var  deSelectedImage : UIImage = #imageLiteral(resourceName: "back")
    
    @IBOutlet weak var imgvIcon: UIImageView!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var viewBackBround: AnimatableView!
    
    //@IBOutlet weak var viewContiner: UIView?
    override func awakeFromNib() {
        self.tintColor = selectedColor
        lbltitle.textColor = .white
        viewBackBround.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
    }
    
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
                
                //imgvIcon.image = #imageLiteral(resourceName: "green_call_icon")
                
              //  lbltitle.textColor = selectedColor
              //  viewContiner?.isHidden = false
                viewBackBround.borderColor = selectedColor
                
            } else {
                
              //  imgvIcon.image = #imageLiteral(resourceName: "green_call_icon")
                  viewBackBround.borderColor = normalBorderColor
               // viewContiner?.isHidden = true
            }
            
        }
    }
    
}






