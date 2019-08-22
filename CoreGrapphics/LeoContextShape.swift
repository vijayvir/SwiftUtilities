//
//  LeoContextShape.swift
//  Spire
//
//  Created by tecH on 10/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit




@IBDesignable
class LeoContextShape : UIView {
    enum Location : Int  {
    
        case center
        case topLeft
        case topCenter
        case topRight
        case centerLeft
        case centerRight
        case bottomLeft
        case bottomCenter
        case bottomRight
        
        
    }

    enum Shape : Int  {
        
        case circle
        case rectangle
        case oval
        case customRect
        case centerLeft
        case centerRight
        case bottomLeft
        case bottomCenter
        case bottomRight
        
        
    }

    @IBInspectable var bgColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    
    
    
    // MARK: - Gradient
    @IBInspectable var isGradientBG : Bool  = false
    @IBInspectable var isThreeColorGradient : Bool  = false
    @IBInspectable var gradientStartColor_context : UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var gradientMidColor_context : UIColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    @IBInspectable var gradientLastColor_context : UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    @IBInspectable var isVerticalGradient : Bool  = false
    
    
    
     @IBInspectable var isStroke : Bool  = false
    @IBInspectable var strokeColor : UIColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    @IBInspectable var strokeWidth : CGFloat  = 0
    @IBInspectable var strokeCornerRadius : CGFloat  = 0
    
    
    @IBInspectable var isShadow : Bool  = false
    @IBInspectable var shadowColor : UIColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    @IBInspectable var blurShadow : CGFloat  = 0
    @IBInspectable var offsetShadow:CGSize = CGSize(width: 0, height: 0)
   
    @IBInspectable var isCliping : Bool  = true
    @IBInspectable var clipShape : Int  = 10
    var shapeEnum : Shape {
        return Shape(rawValue: clipShape) ?? .bottomRight
    }
    
    @IBInspectable var startAngle : Double  = 0
    @IBInspectable var endAngle : Double  = 360
    @IBInspectable var isClockVise : Bool  = true
    @IBInspectable var offsetWidth:CGFloat = 1
    
    
    @IBInspectable var shapeLocation : Int  = 1
    var location  : Location {
        return Location(rawValue: shapeLocation) ?? .center
    }
    
   @IBInspectable var leftTop : CGPoint  = CGPoint(x: 0, y: 0)
   @IBInspectable var leftbottom : CGPoint  = CGPoint(x: 0, y: 0)
   @IBInspectable var rightTop : CGPoint  = CGPoint(x: 0, y: 0)
   @IBInspectable var rightbottom : CGPoint  = CGPoint(x: 0, y: 0)
   @IBInspectable var isClosed : Bool  = true
    
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        super.draw(rect)
       // self.layer.backgroundColor = UIColor.red.cgColor
        let context = UIGraphicsGetCurrentContext()
  
        context?.saveGState()
        
        context?.beginTransparencyLayer(auxiliaryInfo: nil )
        
        
        
        let halfMinXY:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        
        
        
   
        
        let path = UIBezierPath()
        
        var circleStartPoint = CGPoint(x: 0, y: 0)
        
        switch location {
       
        case .center:
             circleStartPoint = CGPoint(x:bounds.size.width/2, y: bounds.size.height/2)
        case .topLeft:
              circleStartPoint = CGPoint(x:bounds.size.width/2, y: bounds.size.height/4)
        case .topCenter:
              path.move(to:circleStartPoint )
        case .topRight:
              path.move(to:circleStartPoint )
        case .centerLeft:
              path.move(to:circleStartPoint )
        case .centerRight:
              path.move(to:circleStartPoint )
        case .bottomLeft:
              path.move(to:circleStartPoint )
        case .bottomCenter:
              path.move(to:circleStartPoint )
        case .bottomRight:
              path.move(to:circleStartPoint )
       
        }
        
     //   circleStartPoint = CGPoint(x:bounds.size.width/2, y: bounds.size.height/2)
        path.move(to:circleStartPoint )
        
      
        
        // center
      //  circlePath.move(to: CGPoint(x: bounds.size.width/2, y: bounds.size.height/2))
        if isCliping {
            switch shapeEnum {
                
            case .circle:
                
                
                path.addArc(withCenter: circleStartPoint ,
                            radius: CGFloat( halfMinXY - (offsetWidth/2) ),
                            startAngle: CGFloat(startAngle * Double.pi / 180),
                            endAngle: CGFloat(endAngle * Double.pi / 180),
                            clockwise: isClockVise)
                path.addClip()
                
                
                
            case .rectangle:
                let rectMinusOffSet = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
                
                path.append(UIBezierPath(roundedRect: rectMinusOffSet , cornerRadius: strokeCornerRadius))
                
                path.addClip()
                
                print("")
            case .oval:
                
                let rectMinusOffSet = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
                path.append(UIBezierPath(ovalIn: rectMinusOffSet))
                path.addClip()
                
            
            case .customRect:
                
                let customPath = UIBezierPath()
                
                customPath.move(to: CGPoint(x: 0 + leftTop.x, y: 0 + leftTop.y ))
                customPath.addLine(to: CGPoint(x: 0 + leftbottom.x , y: bounds.maxY + leftbottom.y ) )
                customPath.addLine(to:  CGPoint(x: bounds.maxX + rightbottom.x , y: bounds.maxY + rightbottom .y ))
                customPath.addLine(to:  CGPoint(x: bounds.maxX + rightTop.x  , y: 0 +  rightTop .y ))
                
                
                if isClosed{
                    customPath.close()
                    
                }
                path.append(customPath)
                path.addClip()
                
                print("")
            case .centerLeft:
                print("")
            case .centerRight:
                print("")
            case .bottomLeft:
                print("")
            case .bottomCenter:
                print("")
            case .bottomRight:
                print("")
                
            }
        }
    
    
        
        //let rectt =  CGPath(ellipseIn: rect, transform: nil)
        
        let rectBackGround =  UIBezierPath(rect: rect)
        context?.addPath(rectBackGround.cgPath)
        context?.setFillColor(bgColor.cgColor)
        context?.fillPath()
        path.removeAllPoints()
   
    
        
     
        
        
        if isGradientBG {
            context?.saveGState()
            
            var locations: [CGFloat] = [0.0,1.0]
            
            var colors = [gradientStartColor_context.cgColor,
                          
                          gradientLastColor_context.cgColor]
            
            if isThreeColorGradient {
                locations = [0.0,0.5,1.0]
                colors = [gradientStartColor_context.cgColor,
                          gradientMidColor_context.cgColor,
                          gradientLastColor_context.cgColor]
            }
            
            let colorspace = CGColorSpaceCreateDeviceRGB()
            
            let gradient = CGGradient(colorsSpace: colorspace,
                                      colors: colors as CFArray, locations: locations)
            
            var startPoint =  CGPoint()
            var endPoint  = CGPoint()
            
            if isVerticalGradient {
                startPoint.x = 0
                startPoint.y = 0
                endPoint.x = 0
                endPoint.y = rect.height
            }else {
                startPoint.x = 0
                startPoint.y = 0
                endPoint.x = rect.width
                endPoint.y = rect.height
            }
            
            
            context?.drawLinearGradient(gradient!,
                                        start: startPoint,
                                        end: endPoint,
                                        options: .drawsBeforeStartLocation)
            
            context?.restoreGState()
        }
        
        
        if isShadow {
            context?.setShadow(offset: offsetShadow, blur: blurShadow, color: shadowColor.cgColor)
        }
        
        
        if isStroke {
            
            
            switch shapeEnum {
                
            case .circle:
                
                
                path.addArc(withCenter: circleStartPoint ,
                            radius: CGFloat( halfMinXY - (offsetWidth/2) ),
                            startAngle: CGFloat(0),
                            endAngle: CGFloat(50),
                            clockwise: true)
                path.addClip()
                
                
                
            case .rectangle:
                let rectMinusOffSet = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
                
                path.append(UIBezierPath(roundedRect: rectMinusOffSet , cornerRadius: strokeCornerRadius))
                
                 path.addClip()
                print("")
            case .oval:
                print("")
                
                let rectMinusOffSet = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
                
                path.append(UIBezierPath(ovalIn: rectMinusOffSet))
                
                path.addClip()
                
            case .customRect:
                let customPath = UIBezierPath()
                
            
                
                customPath.move(to: CGPoint(x: 0 + leftTop.x, y: 0 + leftTop.y ))
                customPath.addLine(to: CGPoint(x: 0 + leftbottom.x , y: bounds.maxY + leftbottom.y ) )
                customPath.addLine(to:  CGPoint(x: bounds.maxX + rightbottom.x , y: bounds.maxY + rightbottom .y ))
                customPath.addLine(to:  CGPoint(x: bounds.maxX + rightTop.x  , y: 0 +  rightTop .y ))
                
                if isClosed{
                    customPath.close()
                    
                }
                path.append(customPath)
                path.addClip()
                
            case .centerLeft:
                print("")
            case .centerRight:
                print("")
            case .bottomLeft:
                print("")
            case .bottomCenter:
                print("")
            case .bottomRight:
                print("")
                
            }
            context?.addPath(path.cgPath)
            
            context?.setLineWidth(strokeWidth)
            
            context?.setStrokeColor(strokeColor.cgColor)
            
            context?.strokePath()

        }

        context?.endTransparencyLayer()
        context?.restoreGState()
        
    }

}
