//
//  PointView.swift
//  iSpy
//
//  Created by tecH on 18/04/19.
//  Copyright © 2019 tecH. All rights reserved.
//

import UIKit
extension CGSize {
    func sizeRation(with :  CGSize)-> CGSize {
        return CGSize(width: self.width / with.width, height: self.height / with.height)
    }
}
extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

class PointView: UIView {
    
    var closureDidSet : (() -> Void)?
    
    
    var point : CGPoint? {
  
        didSet {
            if point != nil {
                 self.closureDidSet?()
            }
           
            
        }
   
    }
    override func draw(_ rect: CGRect) {
      //  Drawing code
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            
            point = firstTouch.location(in: self)
    
      
        
        
            
            if point != nil {
                
              if self.point(inside: point!, with: event) {
                     draw(pointe:point!)
                }
               
                
                
            }
            
        }
        
    }
    
    

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let firstTouch = touches.first {
            
            point = firstTouch.location(in: self)
            
            
            if point != nil {
                
                if self.point(inside: point!, with: event) {
                    draw(pointe:point!)
                }
                
                
                
            }
            
        }
    }
    func draw(pointe : CGPoint) {
        self.layer.sublayers?.removeAll()
        let  superFrame  : CGRect = self.bounds
        
        
        
        let  frame : CGRect = CGRect(x: ( pointe.x  ) - 35,
                                     y: ( pointe.y  ) - 35,
                                     width: 70,
                                     height: 70)
        let shapelayer : CAShapeLayer = CAShapeLayer()
        
        let path = CGMutablePath()
        
        path.addRect(frame)
        path.addRect(superFrame)
        shapelayer.path = path
        self.clipsToBounds  = true
        shapelayer.fillColor = UIColor.white.withAlphaComponent(0.6).cgColor
        
        shapelayer.fillRule = .evenOdd
        self.alpha = 1
        self.layer.addSublayer(shapelayer)
    }
    
}
