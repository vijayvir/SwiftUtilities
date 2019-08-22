//
//  LeoRadioBox.swift
//  Spire
//
//  Created by tecH on 22/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit

@IBDesignable
class LeoRadioBox: UIButton {
//https://www.raywenderlich.com/410-core-graphics-tutorial-part-2-gradients-and-contexts
    override var isSelected: Bool{
        didSet{
            isSelectedBox = isSelected
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var offsetWidth:CGFloat = 1
    @IBInspectable var strokeWidth:CGFloat = 1
    @IBInspectable var selectedColor : UIColor =  #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    @IBInspectable var bgColor : UIColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable var isSelectedBox: Bool  = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
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
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.addPath(outerPath.cgPath)
        context?.setFillColor(bgColor.cgColor)
        context?.fillPath()
        
        context?.addPath(outerPath.cgPath)
        context?.setStrokeColor(selectedColor.cgColor)
        context?.setLineWidth(strokeWidth)

        context?.strokePath()
        
        if isSelectedBox {
            let innerPath = UIBezierPath()
            innerPath.addArc(withCenter: circleStartPoint ,
                             radius: CGFloat( halfMinXY/1.4 + (halfMaxXY - halfMinXY )  - (offsetWidth/2)  - strokeWidth   ),
                             startAngle: CGFloat(0 * Double.pi / 180),
                             endAngle: CGFloat(360 * Double.pi / 180),
                             clockwise: true)
            context?.setFillColor(selectedColor.cgColor)
            context?.addPath(innerPath.cgPath)
            context?.fillPath()
        }
        context?.restoreGState()
    }
}
