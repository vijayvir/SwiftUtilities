//
//  SPLabel.swift
//  Spire
//
//  Created by tecH on 07/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit
// https://stackoverflow.com/questions/32771864/draw-text-along-circular-path-in-swift-for-ios

extension CGContext {
    func drawLinearGradient(
        in rect: CGRect,
        startingWith startColor: CGColor,
        finishingWith endColor: CGColor
        ) {
        // 1
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 2
        let locations = [0.0, 1.0] as [CGFloat]
        
        // 3
        let colors = [startColor, endColor] as CFArray
        
        // 4
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors,
            locations: locations
            ) else {
                return
        }
    }
}



@IBDesignable
class LeoAttributeLabel : UIView {
    
    func drawBlueCircle(in context: CGContext) {
        context.saveGState()
        context.setFillColor(UIColor.green.cgColor)
        context.addEllipse(in: bounds)
        context.drawPath(using: .fill)
        context.restoreGState()
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            self.setNeedsLayout()
            self.setNeedsDisplay()
            
        }
        
    }
    
    
    
    // MARK: - View
    @IBInspectable var backgroundColor_context : UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var borderColor : UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var borderWidth :  CGFloat = 0
    @IBInspectable var isBorderGradient : Bool  = false
    @IBInspectable var gradientStartColor_Border : UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var gradientLastColor_Border : UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    
    
    // MARK: - Gradient
    @IBInspectable var isBackGroundGradient : Bool  = false
    @IBInspectable var isThreeColorGradient : Bool  = false
    @IBInspectable var gradientStartColor_context : UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var gradientMidColor_context : UIColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    @IBInspectable var gradientLastColor_context : UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    @IBInspectable var isVerticalGradient : Bool  = false
    
    
    
    
    // MARK: - Text Attributes
    @IBInspectable var text : String? = ""
    @IBInspectable var fontSize_text : CGFloat = 3
    @IBInspectable var strokeWidth_text : CGFloat = 3
    @IBInspectable var strokeColor_text: UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var foregroundColor_text: UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var backgroundColor_text: UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var alignment_text: Int = 0
    @IBInspectable var fontName_text : String?
    @IBInspectable var font :  UIFont =  UIFont.systemFont(ofSize:  UIFont.systemFontSize)
    
    
    @IBInspectable var isShowfontName : Bool  = false
    @IBInspectable var fontFamilyIndex : CGPoint = CGPoint(x: -1, y: -1 )
    var  leoFontName : String? {
        
        if Int(fontFamilyIndex.x) >= 0 && Int(fontFamilyIndex.x) < UIFont.familyNames.sorted().count {
            
            let fontNames = UIFont.fontNames(forFamilyName: UIFont.familyNames.sorted()[Int(fontFamilyIndex.x)])
            
            if Int(fontFamilyIndex.y) >= 0 && Int(fontFamilyIndex.y) < fontNames.count {
                
                return  fontNames[Int(fontFamilyIndex.y)]
            }
            
            
            return fontNames.first ?? nil
            
        }
        
        
        
        return nil
    }
    
    
    
    @IBInspectable var isTextGradient : Bool  = false
    @IBInspectable var gradientStartColor_text : UIColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    @IBInspectable var gradientLastColor_text : UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    
  
    @IBInspectable var leading_text : CGFloat  = 0
    @IBInspectable var top_text : CGFloat  = 0
    @IBInspectable var trailing_text : CGFloat  = 0
    
    @IBInspectable var isCenterY : Bool  = false

    @IBInspectable var isSizeOverride : Bool  = false
    //    @IBInspectable var extraSize : CGSize  = CGSize(width: 0, height: 0)
    //
    
    
    //https://www.techotopia.com/index.php/An_iOS_8_Swift_Graphics_Tutorial_using_Core_Graphics_and_Core_Image
    //https://www.raywenderlich.com/475829-core-graphics-tutorial-lines-rectangles-and-gradients
    
  
    
    
    
    func fontes() {
        
        for family in UIFont.familyNames.sorted() {
            
            let fontNames = UIFont.fontNames(forFamilyName: family)
            print(family, fontNames)
            
            
        }
        
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.isOpaque =  true
        
        
        let context = UIGraphicsGetCurrentContext()
        //        context?.saveGState()
        //        context?.clear(self.bounds)
        //        context?.restoreGState()
        //
        context?.saveGState()
        context?.setFillColor(backgroundColor_context.cgColor)
        context?.fill(bounds)
        context?.restoreGState()
        
        
  
        
        //        context?.saveGState()
        //        context?.setFillColor(UIColor.green.cgColor)
        //        context?.addEllipse(in: bounds)
        //        context?.clip()
        //        context?.drawPath(using: .fill)
        //        context?.fill(rect)
        //        context?.restoreGState()
        //
        //
        //        context?.saveGState()
        //
        //
        //        let y = bounds.maxY / 2
        //        let minX = bounds.minX
        //        let maxX = bounds.maxX
        //
        //        context?.setStrokeColor(UIColor.red.cgColor)
        //        context?.setLineWidth(1.0)
        //        context?.move(to: CGPoint(x: minX, y: y))
        //        context?.addLine(to: CGPoint(x: maxX, y: y))
        //        context?.strokePath()
        //        context?.restoreGState()
        
        
        if isBackGroundGradient {
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
                endPoint.y = bounds.height
            }else {
                startPoint.x = 0
                startPoint.y = 0
                endPoint.x = bounds.width
                endPoint.y = bounds.height
            }
            
            
            context?.drawLinearGradient(gradient!,
                                        start: startPoint,
                                        end: endPoint,
                                        options: .drawsBeforeStartLocation)
            
            context?.restoreGState()
        }
        
        
        
        
        
        
        
        if text != nil {
            context?.saveGState()
            
            var  textTextContent = text!
            
            if  leoFontName != nil {
             if isShowfontName {
                     textTextContent = leoFontName! +  text!
                }
            
            }
            
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = NSTextAlignment(rawValue:alignment_text) ?? .left
            
            var font = UIFont.systemFont(ofSize:fontSize_text)
            
            if fontName_text != nil {
                if let fontNew = UIFont(name: fontName_text!, size: fontSize_text) {
                    font = fontNew
                    
                }
                
                
            }
            
            if  leoFontName != nil {
                if let fontNew = UIFont(name: leoFontName!, size: fontSize_text) {
                    font = fontNew
                    
                }
            }
            
            
            
            
            var textFontAttributes : [NSAttributedString.Key: Any] = [
                
                
                .strokeWidth  : -strokeWidth_text,
                .strokeColor : strokeColor_text,
                .foregroundColor : foregroundColor_text,
                .backgroundColor : backgroundColor_text,
                .font : font,
                .paragraphStyle: textStyle,
            ]
            textFontAttributes[.font] = font
            
            var  textSize: CGSize = textTextContent.size(withAttributes: [.font: font])
            
            //context?.clip(to: bounds)
            
            var  startPoint_text : CGPoint = CGPoint(x: leading_text, y: top_text)
            
            
            if isCenterY {
             startPoint_text.y =  startPoint_text.y + self.center.y
                
            } else {
                
            }
            
            
            
            textSize = CGSize(width: textSize.width - trailing_text, height: textSize.height)
            
            var   textFrame = CGRect(origin: startPoint_text , size: textSize)
            
            
            
        if isSizeOverride {
                
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: self.bounds.width  - trailing_text , height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
                
                let newFrame = CGSize(width: self.bounds.width  - trailing_text  , height:  textTextHeight )
                
                textFrame = CGRect(origin: startPoint_text , size: newFrame)
                
            }
            
            
            
            
            
            
            
        if !isTextGradient {
                
                textTextContent.draw(in: textFrame , withAttributes: textFontAttributes)
                
            }
            
            
            
            
            
            if isTextGradient {
                
         
                let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                          colors: [gradientStartColor_text.cgColor,
                                                   gradientLastColor_text.cgColor] as CFArray, locations: [0, 1])!
                
                
                var startPoint =  CGPoint()
                var endPoint  = CGPoint()
                
                
                
                startPoint.x = textFrame.minX
                startPoint.y = textFrame.minY
                endPoint.x = textFrame.minX
                endPoint.y = textFrame.maxY
                
                
                
                
                context?.beginTransparencyLayer(auxiliaryInfo: nil)
                
                context?.saveGState()
                
                
                
                var  mutablePath : CGMutablePath = CGMutablePath()
                   //  mutablePath.move(to: startPoint)
                
                appendToPath(path: &mutablePath, string: textTextContent,
                             attribute: textFontAttributes,
                             targetFrame: textFrame,
                             startPoint: startPoint,
                             trailing: trailing_text)
          

  
                let textPath = UIBezierPath(cgPath: mutablePath)

                context?.addPath(textPath.cgPath)
                textPath.addClip()
                
                
//                context?.textMatrix = .identity
//                context?.translateBy(x: 0, y: bounds.size.height)
//                context?.scaleBy(x: 1.0, y: -1.0)
//
//                let path = CGMutablePath()
//                path.addRect(bounds)
//                // 4
//                let attrString = NSAttributedString(string: text!)
//                // 5
//                let framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
//                // 6
//                let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, nil)
//                // 7
//                CTFrameDraw(frame, context!)
                
                
            
//                context?.scaleBy(x: 1.0, y: -1)
//
                
                
                context?.drawLinearGradient(gradient, start: startPoint,
                                            end: endPoint,
                                            options: [.drawsBeforeStartLocation])
                
                context?.restoreGState()
                
                context?.saveGState()
     
                context?.restoreGState()
                
                
                context?.endTransparencyLayer()
                
            }
            
            
            //// Gradient Declarations
            
            
            context?.restoreGState()
            
        }
        
        
        context?.saveGState()
//        context?.setStrokeColor(borderColor.cgColor)
//        context?.stroke(bounds, width: borderWidth)
//
      
        
        if isBorderGradient  {
            
            let textPath = UIBezierPath(rect: bounds)
            
            
            context?.setLineWidth(borderWidth)
            context?.addPath(textPath.cgPath)
            context?.replacePathWithStrokedPath()
            context?.clip()
            
            
            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                      colors: [gradientStartColor_Border.cgColor,
                                               gradientLastColor_Border.cgColor] as CFArray, locations: [0, 1])!
            let start = bounds.origin
            let end = CGPoint(x: bounds.maxX, y: bounds.maxY)
            
            context?.drawLinearGradient(gradient, start: start,
                                        end: end,
                                        options: [.drawsBeforeStartLocation])
            
        }else {
                    context?.setStrokeColor(borderColor.cgColor)
                    context?.stroke(bounds, width: borderWidth)
        }

        
        
        context?.restoreGState()
        
        
        
//        let size = self.bounds.size
//
//        context?.translateBy (x: size.width / 2, y: size.height / 2)
//        context?.scaleBy (x: 1, y: -1)
//
//        centreArcPerpendicular(text: "Hello round world fgdjg fdgs fgdsug fuysdguyfg ysudgyfugsud fgyusdgfuy gdsufgy udsgfuy", context: context!, radius: 100, angle: 0, colour: UIColor.red, font: UIFont.systemFont(ofSize: 16), clockwise: true)
//        centreArcPerpendicular(text: "Anticlockwise", context: context!, radius: 100, angle: CGFloat(-M_PI_2), colour: UIColor.red, font: UIFont.systemFont(ofSize: 16), clockwise: false)
//        centre(text: "Hello flat world", context: context!, radius: 0, angle: 0 , colour: UIColor.yellow, font: UIFont.systemFont(ofSize: 16), slantAngle: CGFloat(M_PI_4))
//
        
        //
        //        context?.saveGState()
        //
        //        context?.restoreGState()
        
        
        //  context?.sto()
        
        //        context?.setTextDrawingMode(.stroke)
        //           self.textColor = leoStrokeColor
        //
        //
        //        context?.setLineWidth(leoLineJoin)
        //        context?.setLineJoin(.miter)
        //
        //
        //      // self.textColor.setStroke()
        //      //  context?.saveGState()
        //          super.draw(rect)
        //
        //      //   context?.restoreGState()
        //         context?.scaleBy(x: 1.5, y: 1.5)
        //  super.draw(rect)
        //         scaleBy(x sx: CGFloat, y sy: CGFloat)
        
        
        
        // self.shadowOffset = CGSize(width: 0, height: 0)
        // self.shadowOffset = shadowOffset
    }
    
    func some(){
        
        
        
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function)
        some()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        some()
        print(#function)
    }
    
}

func multiplePath(path: inout  CGMutablePath) {
    
//    if (_limitToNumberOfLines && count == _numberOfLines-1)
//    {
//        // check if we reach end of text.
//        if (lineRange.location + lineRange.length < [_text length])
//        {
//            CFDictionaryRef dict = ( CFDictionaryRef)attributes;
//            CFAttributedStringRef truncatedString = CFAttributedStringCreate(NULL, CFSTR("\u2026"), dict);
//
//            CTLineRef token = CTLineCreateWithAttributedString(truncatedString);
//
//            // not possible to display all text, add tail ellipsis.
//            CTLineRef truncatedLine = CTLineCreateTruncatedLine(line, self.bounds.size.width - 20, kCTLineTruncationEnd, token);
//            CFRelease(line); line = nil;
//            line = truncatedLine;
//        }
//    }
}

func appendToPath(path: inout  CGMutablePath ,
                  string : String  ,
                  attribute :  [NSAttributedString.Key: Any] ,
                  targetFrame : CGRect , startPoint : CGPoint , trailing : CGFloat  ){
    let textPath = CGMutablePath()
    let attributedString = NSAttributedString(string: string, attributes: attribute)

    let line = CTLineCreateWithAttributedString(attributedString)
    if let some = line as? CTLine {
        let runs = (CTLineGetGlyphRuns(some) as [AnyObject]) as! [CTRun]
        
    
        let someFrame  = CTLineGetBoundsWithOptions(line ,  [.useGlyphPathBounds])
        print(someFrame)
        
        for (index , run) in runs.enumerated()
        {
            let attributes: NSDictionary = CTRunGetAttributes(run)
            let font = attributes[kCTFontAttributeName as String] as! CTFont
            let count = CTRunGetGlyphCount(run)
            
            
            for index in 0..<count
            {
                let range = CFRangeMake(index, 1)
                var glyph = CGGlyph()
                CTRunGetGlyphs(run, range, &glyph)
                var position = CGPoint()
                
                CTRunGetPositions(run, range, &position)
                
                let xDivider : Int = Int(position.x / (targetFrame.width - trailing ) )
                 let yDivider : CGFloat = startPoint.y
                
                
                 position.x =    position.x  - CGFloat( CGFloat(xDivider) * (targetFrame.width - trailing ) )
                 position.y =    CGFloat( CGFloat(xDivider)  )  * (someFrame.height + abs(someFrame.origin.y) ) + yDivider
        
                print(position)
                
                guard let letterPath = CTFontCreatePathForGlyph(font, glyph, nil)
                    else {
                        continue }
                
                
                let transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: position.x, ty:  position.y )
                
                textPath.addPath(letterPath, transform: transform)
                
            }
        }

        let transform =   CGAffineTransform(translationX: startPoint.x, y: abs(startPoint.y) +  abs(textPath.boundingBoxOfPath.origin.y)  )
  
        path.addPath(textPath, transform: transform)
       
         print(path.boundingBox)
        print(path.boundingBoxOfPath)
        
     //   path.addPath(textPath, transform: transform)
    }
    
    // direct cast to typed ar ray fails for some reason
    
    
}

func centreArcPerpendicular(text str: String, context: CGContext, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, clockwise: Bool){
    // *******************************************************
    // This draws the String str around an arc of radius r,
    // with the text centred at polar angle theta
    // *******************************************************
    
    let characters: [String] = str.map { String($0) } // An array of single character strings, each character in str
    let l = characters.count
    let attributes = [NSAttributedString.Key.font: font]
    
    var arcs: [CGFloat] = [] // This will be the arcs subtended by each character
    var totalArc: CGFloat = 0 // ... and the total arc subtended by the string
    
    // Calculate the arc subtended by each letter and their total
    for i in 0 ..< l {
        arcs += [chordToArc(characters[i].size(withAttributes: attributes).width, radius: r)]
        totalArc += arcs[i]
    }
    
    // Are we writing clockwise (right way up at 12 o'clock, upside down at 6 o'clock)
    // or anti-clockwise (right way up at 6 o'clock)?
    let direction: CGFloat = clockwise ? -1 : 1
    let slantCorrection: CGFloat = clockwise ? -.pi / 2 : .pi / 2
    
    // The centre of the first character will then be at
    // thetaI = theta - totalArc / 2 + arcs[0] / 2
    // But we add the last term inside the loop
    var thetaI = theta - direction * totalArc / 2
    
    for i in 0 ..< l {
        thetaI += direction * arcs[i] / 2
        // Call centerText with each character in turn.
        // Remember to add +/-90º to the slantAngle otherwise
        // the characters will "stack" round the arc rather than "text flow"
        centre(text: characters[i], context: context, radius: r, angle: thetaI, colour: c, font: font, slantAngle: thetaI + slantCorrection)
        // The centre of the next character will then be at
        // thetaI = thetaI + arcs[i] / 2 + arcs[i + 1] / 2
        // but again we leave the last term to the start of the next loop...
        thetaI += direction * arcs[i] / 2
    }
}

func chordToArc(_ chord: CGFloat, radius: CGFloat) -> CGFloat {
    // *******************************************************
    // Simple geometry
    // *******************************************************
    return 2 * asin(chord / (2 * radius))
}

func centre(text str: String, context: CGContext, radius r: CGFloat, angle theta: CGFloat, colour c: UIColor, font: UIFont, slantAngle: CGFloat) {
    // *******************************************************
    // This draws the String str centred at the position
    // specified by the polar coordinates (r, theta)
    // i.e. the x= r * cos(theta) y= r * sin(theta)
    // and rotated by the angle slantAngle
    // *******************************************************
    
    // Set the text attributes
    let attributes = [NSAttributedString.Key.foregroundColor: c, NSAttributedString.Key.font: font]
    //let attributes = [NSForegroundColorAttributeName: c, NSFontAttributeName: font]
    // Save the context
    context.saveGState()
    // Undo the inversion of the Y-axis (or the text goes backwards!)
    context.scaleBy(x: 1, y: -1)
    // Move the origin to the centre of the text (negating the y-axis manually)
    context.translateBy(x: r * cos(theta), y: -(r * sin(theta)))
    // Rotate the coordinate system
    context.rotate(by: -slantAngle)
    // Calculate the width of the text
    let offset = str.size(withAttributes: attributes)
    // Move the origin by half the size of the text
    context.translateBy (x: -offset.width / 2, y: -offset.height / 2) // Move the origin to the centre of the text (negating the y-axis manually)
    // Draw the text
    str.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
    // Restore the context
    context.restoreGState()
}

// *******************************************************
// Playground code to test
// *******************************************************
//let size = CGSize(width: 256, height: 256)
//
//UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
//let context = UIGraphicsGetCurrentContext()!
//// *******************************************************************
//// Scale & translate the context to have 0,0
//// at the centre of the screen maths convention
//// Obviously change your origin to suit...
//// *******************************************************************
//context.translateBy (x: size.width / 2, y: size.height / 2)
//context.scaleBy(x: 1, y: -1)
//
//centreArcPerpendicular(text: "Hello round 🌏 world", context: context, radius: 100, angle: 0, colour: UIColor.red, font: UIFont.systemFont(ofSize: 16), clockwise: true)
//centreArcPerpendicular(text: "Anticlockwise", context: context, radius: 100, angle: CGFloat(-M_PI_2), colour: UIColor.red, font: UIFont.systemFont(ofSize: 16), clockwise: false)
//centre(text: "Hello flat world", context: context, radius: 0, angle: 0 , colour: UIColor.yellow, font: UIFont.systemFont(ofSize: 16), slantAngle: .pi / 4)
//
//
//let image = UIGraphicsGetImageFromCurrentImageContext()
//UIGraphicsEndImageContext()
//
