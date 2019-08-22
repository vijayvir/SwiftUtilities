//
//  LeoVerticalLabelView.swift
//  LeoImagePagerDemo
//
//  Created by tecH on 19/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//
//https://www.raywenderlich.com/392-uicollectionview-custom-layout-tutorial-pinterest

import UIKit

extension  String {
    
    @discardableResult
    func print() -> String {
          Swift.print(self)
        return self
    }
    
     var  log : String {
        Swift.print(self)
        return self
    }
    
}


class LeoVerticalLabelView: UIView {
    
    override func draw(_ rect: CGRect) {
    }
    var label : UILabel?
    @IBInspectable  var textColor : UIColor = .black {
        didSet {
            label?.textColor = textColor
        }
    }
    
    @IBInspectable  var textAlignment0_4 : Int = 0 {
        didSet {
            label?.textAlignment = NSTextAlignment(rawValue: textAlignment0_4) ?? .left
        }
    }
    
    @IBInspectable var clockWise : Bool = true {
        didSet {
            var someCloakwise =  -CGFloat.pi/2
            if !clockWise{
                someCloakwise =  CGFloat.pi/2
            }else {
                someCloakwise =  -CGFloat.pi/2
            }
            let some = CGAffineTransform(rotationAngle: someCloakwise)
                
                .concatenating( CGAffineTransform(translationX: -bounds.maxY/2 +  bounds.maxX / 2  , y: -bounds.maxX/2 +  bounds.maxY / 2))
            label?.transform = some

            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .green
        if label == nil {
             let newFrame = CGRect(x: 0,
                                   y: 0,
                                   width: bounds.maxY,
                                  height: bounds.maxX)

            label =  UILabel(frame: newFrame)
            label?.text = "Some Text dgsg udighuisahdiuhasui"
            self.addSubview(label!)
 
           var someCloakwise =  -CGFloat.pi/2
            if !clockWise{
                someCloakwise =  CGFloat.pi/2
            }else {
                someCloakwise =  -CGFloat.pi/2
            }
            let some = CGAffineTransform(rotationAngle: someCloakwise)

            .concatenating( CGAffineTransform(translationX: -bounds.maxY/2 +  bounds.maxX / 2  , y: -bounds.maxX/2 +  bounds.maxY / 2))
           label?.transform = some
        }
    }
}
