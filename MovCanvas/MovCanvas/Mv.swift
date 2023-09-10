//
//  Mv.swift
//  MovCanvas
//
//  Created by vijayvir on 09/09/23.
//

import Foundation
import Foundation
import UIKit
import AVFoundation
class ViewNext : UIView {
    var pointMe : CGPoint?
    var currentIndex : Int = 0
    var callback: ((Int) ->())?
    var lastCallbak: ((Int) ->())?
    
    var countOfArray : Int = 0
    func configure(count : Int){
        countOfArray = count
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
       
    }
    @objc private func handleTapGesture() {
       print("tap gesture executed...")
        if currentIndex < countOfArray{
           
            if  currentIndex  >= countOfArray {
                lastCallbak?(countOfArray - 1)
            }else {
                currentIndex = currentIndex + 1
                callback?(currentIndex)
            }
         
         
        }
     
    }
}
class BusCanvasView: UIView {
    let synthesizer = AVSpeechSynthesizer()

    var visibleUpto :  CGFloat = 0
    var angle :  CGFloat = 0
    var selectedState : CGFloat = 0

    var closureDidTap : ((Int) -> Void)?
    var pathNew = UIBezierPath()
    override class var layerClass : AnyClass {
        return CAShapeLayer.self}
    var shapeLayer: CAShapeLayer { return self.layer as! CAShapeLayer }
    func makePath(){
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.path = pathNew.cgPath
        
    }
    func clearPAth(point : CGPoint){
        pathNew = UIBezierPath()
        pathNew = UIBezierPath(arcCenter: point, radius: 2, startAngle: 0, endAngle: 360, clockwise: true)
        makePath()
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     
     */
    var traingel = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    var circlebackw = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    var circlefront = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    var reactangle = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    var reactangleTwo = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    var starColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    var pentagonColor = UIColor(red: 0.978, green: 0.978, blue: 0.978, alpha: 1.000)
    var squareColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

    
    var pointView : UIView?
    var nextView : UIView?
    var pathme : MyBezierPath = MoveToCanvas.pathme()
    func layerScaleAnimation(layer: CALayer, duration: CFTimeInterval, fromValue: CGFloat, toValue: CGFloat) {
        let timing = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")

        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timing)
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = fromValue
        scaleAnimation.repeatCount  = .infinity
        scaleAnimation.toValue = toValue
        layer.add(scaleAnimation, forKey: "scale")
        CATransaction.commit()
    }
    var dome : ViewNext?
    func configure(){
      
        pointView?.removeFromSuperview()
        pointView = UIView(frame: CGRect(origin: pathme.firstMe(frame: self.bounds , resizing: .aspectFit), size: CGSize(width: 10, height: 10)))
        pointView?.backgroundColor = .red
        
        self.addSubview(pointView!)
        
        
         
        let someNExt = pathme.NextMe(index: 1 ,frame: self.bounds , resizing: .aspectFit)
        switch someNExt.0 {
            
        case .move(let point ):
            dome = ViewNext(frame: CGRect(origin: CGPoint(x: point.x * someNExt.1.width / 240,  y: point.y * someNExt.1.height / 240 ) , size: CGSize(width: 20, height: 20)))
            
        case .addLine(let point ):
            dome = ViewNext(frame: CGRect(origin: CGPoint(x: point.x * someNExt.1.width / 240,  y: point.y * someNExt.1.height / 240 ) , size: CGSize(width: 20, height: 20)))
        case .addCurver(_, _, _):
                                print("")
        }
        
       
        
        
        
        
        dome?.backgroundColor = .yellow
        
        var domeCenter =  pathme.NextMe(index: 1 ,frame: self.bounds , resizing: .aspectFit)
        switch domeCenter.0{
            
        case .move(let point):
            print("")
            dome?.center = CGPoint(x: point.x * someNExt.1.width / 240,  y: point.y * someNExt.1.height / 240 )
        case .addLine(let point):
            print("")
            dome?.center =  CGPoint(x: point.x * someNExt.1.width / 240,  y: point.y * someNExt.1.height / 240 )
        case .addCurver(_, _, _):
            print("")
          
        }
        
    
        pathNew = UIBezierPath(arcCenter:  pathme.firstMe(frame: self.bounds , resizing: .aspectFit), radius: 1, startAngle: 0, endAngle: 360, clockwise: true)
  
        dome?.configure(count: pathme.pointMe.count)
//        dome?.lastCallbak = { index in
//            self.pathNew.addLine(to: self.pathme.NextMe(index: index ,frame: self.bounds , resizing: .aspectFit))
//            self.makePath()
//            self.dome?.isHidden = true
//
//        }
        dome?.callback = { index in
            print(index , "👗👗👗👗👗")
            
            var kke = self.pathme.NextMe(index: index ,frame: self.bounds , resizing: .aspectFit)
            
            switch kke.0 {
                
            case .move(let point):
                self.pathNew.move(to:  CGPoint(x: point.x * kke.1.width / 240,  y: point.y * kke.1.height / 240 ))
               
            case .addLine(let point):
                self.pathNew.addLine(to:  CGPoint(x: point.x * kke.1.width / 240,  y: point.y * kke.1.height / 240 ))
            case .addCurver(let point, let c1 , let c2):
                self.pathNew.addCurve(to:
                                        CGPoint(x: point.x * kke.1.width / 240,  y: point.y * kke.1.height / 240 ) ,
                                      controlPoint1:  CGPoint(x: c1.x * kke.1.width / 240,  y: c1.y * kke.1.height / 240 ),
                                      controlPoint2:  CGPoint(x: c2.x * kke.1.width / 240,  y: c2.y * kke.1.height / 240 ))
            }
            

            self.makePath()
            if  index + 1  < self.pathme.pointMe.count {
         
                var somedomeCenter =  self.pathme.NextMe(index: index + 1 ,frame: self.bounds , resizing: .aspectFit)
                switch somedomeCenter .0{
                    
                case .move(let point):
                    print("")
                    self.dome?.center = CGPoint(x: point.x * someNExt.1.width / 240,  y: point.y * someNExt.1.height / 240 )
                case .addLine(let point):
                    print("")
                    self.dome?.center =  CGPoint(x: point.x * someNExt.1.width / 240,  y: point.y * someNExt.1.height / 240 )
                case .addCurver(let point, _, _):
                    print("")
                    self.dome?.center =  CGPoint(x: point.x * someNExt.1.width / 240,  y: point.y * someNExt.1.height / 240 )
                  
                }
                
                
                
            }else{
                self.dome?.isHidden = true
            }
          
        }
        self.addSubview(dome!)
    
        layerScaleAnimation(layer:   dome!.layer, duration: 0.7, fromValue: 0.5, toValue: 1)
    }
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        MoveToCanvas.drawCanvas1(frame: self.bounds , resizing: .aspectFit)
 
    
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        if UIDevice.current.userInterfaceIdiom != .pad {
            let touch = touches.first
            if let tapPoint = touch?.location(in: self){
                
                
                selectState(tapPoint : tapPoint)
            }
        }
        
        
        
    }
    func clear () {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(self.bounds)
        }
        self.setNeedsDisplay()
    }
    
    


    func selectState(tapPoint:CGPoint) {
        

        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(self.bounds)
        }
        self.setNeedsDisplay()

    }
    func angleFromPoint(tapPoint:CGPoint) {
        
        
        //        if ClockStyleKit.shouldDraw(tapLocation: tapPoint, frame:  self.bounds, resizing: .aspectFit){
        //
        //        }else {
        //            return
        //        }
        //
        
        
        let  x = self.center.x;
        
        let y = self.center.y;
        
        let centerX = self.bounds.size.width/2
        let centerY = self.bounds.size.height/2
        
        //  print(self.bounds.size.width)
        
        // print(self.frame)
        //   print(self.center)
        //print(x,y, "--------------------------------")
        
        
        let dx = tapPoint.x - centerX;
        let dy = tapPoint.y - centerY;
        
        
        
        let radians = atan2(dy,dx); // in radians
        //   print(x,y, "----------radians---------------------" , radians)
        
        //number * 180 / .pi
        
        let degrees = radians * 180 / .pi; // in degrees
        
        print(degrees ,"" )
        
        //        if (degrees < 0) {
        //            return CGFloat(fabsf(Float(degrees)));
        //        }else {
        //         return 360 - degrees;
        //        }
        if let context = UIGraphicsGetCurrentContext() {
            //context.clear(self.bounds)//
        }
        
        
        angle = degrees
        
        
        
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(self.bounds)
        }
        self.setNeedsDisplay()
        
        
    }
    
    
    func angleToPoint(tapPoint:CGPoint) -> CGFloat{
        
        
        
        
        
        let dx =  self.bounds.origin.x - tapPoint.x
        let dy =  self.bounds.origin.y - tapPoint.y
        let radians = atan2(dy, dx) + .pi // Angel in radian
        
        let degree = radians * (180 / .pi)  // Angel in degree
        print("angle is off = \(degree)")
        return degree
    }
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        if let tapPoint = touch?.location(in: self){
            
            self.angleFromPoint(tapPoint: tapPoint)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let tapPoint = touch?.location(in: self){
            
            //     self.angleFromPoint(tapPoint: tapPoint)
            
        }
    }
    
    
    
    
    
    
}
