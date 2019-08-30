//
//  LeoContextPattern.swift
//  Spire
//
//  Created by tecH on 20/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit
@IBDesignable
class LeoContextPattern: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let drawPattern: CGPatternDrawPatternCallback = { _, context in
//        context.addArc(
//            center: CGPoint(x: 20, y: 20), radius: 10.0,
//            startAngle: 0, endAngle: CGFloat(2.0 * .pi),
//            clockwise: false)
//        context.setFillColor(UIColor.orange.cgColor)
//        context.fillPath()
        
        //// Group
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        
        //// Oval Drawing
        
        context.saveGState()
        context.setBlendMode(.screen)
        
       // let ovalPath = UIBezierPath(ovalIn: CGRect(x: 1, y: 3, width: 10, height: 10))
        
        
        context.addArc(
            center: CGPoint(x: 10, y: 10), radius: 10.0,
            startAngle: 0, endAngle: CGFloat(2.0 * .pi),
            clockwise: false)
        
       // context.addPath(ovalPath.cgPath)
        context.setFillColor(UIColor.blue.cgColor)
   
        context.fillPath()
        
//
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(0.5)
//
//
//        CATransaction.commit()
        
        
        
        
        context.restoreGState()
        
        
        //// Oval 2 Drawing
        context.saveGState()
        context.setBlendMode(.screen)
        
    
   
        
        context.addArc(
            center: CGPoint(x: 20, y: 10), radius: 10.0,
            startAngle: 0, endAngle: CGFloat(2.0 * .pi),
            clockwise: false)

        context.setFillColor(UIColor.green.cgColor)
        
        context.fillPath()
        
        
        context.restoreGState()
        
        
        //// Oval 3 Drawing
        context.saveGState()
        context.setBlendMode(.screen)
        
        context.addArc(
            center: CGPoint(x: 20, y: 20), radius: 10.0,
            startAngle: 0, endAngle: CGFloat(2.0 * .pi),
            clockwise: false)
        
        context.setFillColor(UIColor.red.cgColor)
        
        context.fillPath()
        
        context.restoreGState()
        
        
        context.endTransparencyLayer()
        context.restoreGState()

        
        
        
    }
    
    
    override func draw(_ rect: CGRect) {
  
        let context = UIGraphicsGetCurrentContext()!
        // 2
        context.saveGState()
     
        //UIColor.orange.setFill()
             let patternSpace = CGColorSpace(patternBaseSpace: nil)!
        var callbacks = CGPatternCallbacks(
            version: 0, drawPattern: drawPattern, releaseInfo: nil)
        
        let pattern = CGPattern(
            info: nil,
            bounds: CGRect(x: 0, y: 0, width: 20, height: 20),
            matrix: CGAffineTransform(scaleX: 5, y: 5),
            xStep: 50,
            yStep: 50,
            tiling: .constantSpacing,
            isColored: true,
            callbacks: &callbacks)
        
        var alpha : CGFloat = 1.0
        
       
        // 2
        context.setFillColorSpace(patternSpace)
        
        context.setFillPattern(pattern!, colorComponents: &alpha)
        
        context.fill(rect)
        
        context.restoreGState()
        
    }
}
