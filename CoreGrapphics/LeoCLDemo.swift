//
//  LeoCLDemo.swift
//  Spire
//
//  Created by tecH on 23/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit

//https://www.calayer.com

@IBDesignable
class LeoRadioBoxCA: UIButton {
    override var isSelected: Bool{
        didSet{
            isSelectedBox = isSelected
            
            
            for layer  in self.layer.sublayers ?? [] {
                
  
                if layer.name.leoSafe() ==  "LayerMe" {
                    layer.removeAllAnimations()
                    layer.removeFromSuperlayer()
                }

                
                
                
            }
            
          setNeedsDisplay()
  
        }
    }
    
    @IBInspectable var offsetWidth:CGFloat = 1
    @IBInspectable var strokeWidth:CGFloat = 1
    @IBInspectable var selectedColor : UIColor =  #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    @IBInspectable var bgColor : UIColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable var isSelectedBox: Bool  = false

    
    func configure() {
        self.tintColor = .clear
        self.backgroundColor = .clear
        self.isOpaque =  true

        let halfMinXY:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let halfMaxXY:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        let  circleStartPoint =  CGPoint(x:bounds.size.width/2, y: bounds.size.height/2)
        
        let outerPath = UIBezierPath()
        outerPath.addArc(withCenter: circleStartPoint ,
                         radius: CGFloat( halfMinXY + (halfMaxXY - halfMinXY ) - (offsetWidth/2) - strokeWidth ),
                         startAngle: CGFloat(0 * Double.pi / 180),
                         endAngle: CGFloat(360 * Double.pi / 180),
                         clockwise: true)
        
        
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "LayerMe"
        
        shapeLayer.lineWidth = strokeWidth
        shapeLayer.fillColor = bgColor.cgColor
        shapeLayer.strokeColor = selectedColor.cgColor
        
        shapeLayer.path = outerPath.cgPath
        self.layer.addSublayer(shapeLayer)
        
   
        
     
            let innerPath = UIBezierPath()
            innerPath.move(to: circleStartPoint)
            innerPath.addArc(withCenter: CGPoint(x: 0, y: 0) ,
                             radius: CGFloat( halfMinXY/1.4 + (halfMaxXY - halfMinXY )  - (offsetWidth/2)  - strokeWidth   ),
                             startAngle: CGFloat(0 * Double.pi / 180),
                             endAngle: CGFloat(360 * Double.pi / 180),
                             clockwise: true)
            
            let shapeLayer2 = CAShapeLayer()

            shapeLayer2.fillColor = selectedColor.cgColor
            shapeLayer2.name = "LayerMe"
       
            shapeLayer2.position = circleStartPoint
            shapeLayer2.path = innerPath.cgPath
   
            
            let animation = CABasicAnimation(keyPath: "transform.scale")
        
           if isSelectedBox {
            animation.toValue =   CATransform3DScale(shapeLayer2.transform, 1, 1, 0)
            animation.fromValue = CATransform3DScale(shapeLayer2.transform, 0.5, 0.5, 0)
            
            
      
           }else {
            animation.fromValue =  CATransform3DScale(shapeLayer2.transform, 1, 1, 0)
            animation.isRemovedOnCompletion = false
    
            animation.toValue =   CATransform3DScale(shapeLayer2.transform,0, 0, 0)
        }
        
            animation.fillMode = CAMediaTimingFillMode.forwards;
            
            animation.duration = 0.1
            animation.repeatCount = 1
            shapeLayer2.add(animation, forKey: "MyAnimation")
            
            
            self.layer.addSublayer(shapeLayer2)
        
        
    }
    
    override func draw(_ rect: CGRect) {
    
        super.draw(rect)
        
         configure()
        
        
    }
    
}
