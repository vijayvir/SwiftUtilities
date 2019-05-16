//
//  LeoLongPressCircle.swift
//  iSpy
//
//  Created by tecH on 14/05/19.
//  Copyright © 2019 tecH. All rights reserved.
//

import Foundation
import UIKit
class LeoLongPressCircle : UIView {
    
    var circle : CAShapeLayer =  CAShapeLayer()
    var drawAnimation : CABasicAnimation?
    @IBOutlet weak var btnCircle: UIButton?
    @IBInspectable  var fillColor: UIColor = .clear
    @IBInspectable  var strokeColor: UIColor = .red
    @IBInspectable  var duration: Double = 10.0
    
   private var closureDidStart:(()->Void)?
   private var closureDidEnd:(()->Void)?
   private var closureDidTouchUpInSide:(()->Void)?
   private var closureDidTouchDown:(()->Void)?
    func configure() -> LeoLongPressCircle {
          var radius : CGFloat =  self.bounds.size.width / 2
        if self.bounds.size.width < self.bounds.size.height {
            radius  =  self.bounds.size.height / 2
        }
        self.circle = CAShapeLayer()
        self.circle.path =  UIBezierPath(roundedRect: CGRect(x: 0,
                                                              y: 0,
                                                              width: 2.0*radius,
                                                              height: 2.0*radius),
                                          cornerRadius: CGFloat(radius)).cgPath
        self.circle.anchorPoint =  CGPoint(x: 1, y:  1)
        self.circle.fillColor = fillColor.cgColor
        self.circle.strokeColor = strokeColor.cgColor
        self.circle.lineWidth = 5
        self.circle.strokeEnd = 0.0
        self.layer.addSublayer(self.circle)
        self.circle.contentsCenter = self.layer.contentsCenter
        self.btnCircle?.addTarget(self, action: #selector(startCircleAnimation), for: UIControl.Event.touchDown)
        self.btnCircle?.addTarget(self, action: #selector(endCircleAnimation), for: UIControl.Event.touchUpInside)
        self.btnCircle?.addTarget(self, action: #selector(touchCancelt), for: UIControl.Event.touchUpOutside)
        
        
        return self
    }
    
    @objc func touchCancelt(){
           self.pauseLayer(layer: circle)
           closureDidTouchUpInSide?()
        
    }
    
    func withDidTouchDown(_ callback : (() -> ())? = nil ) -> LeoLongPressCircle {
        closureDidTouchDown = callback
        return self
    }
    func withDidStart(_ callback : (() -> ())? = nil ) -> LeoLongPressCircle {
     closureDidStart = callback
    return self
    }
    func withDidEnd(_ callback : (() -> ())? = nil ) -> LeoLongPressCircle {
        closureDidEnd = callback
        return self
    }
    func withDidTouchUpInSide(_ callback : (() -> ())? = nil ) -> LeoLongPressCircle {
        closureDidTouchUpInSide = callback
        return self
    }
    
    
    func run(_ callback : (() -> ())? = nil ) {
        callback?()
    }
    
    func reset(){
     self.reset(layer: circle)
        
    }
    @objc func startCircleAnimation(){
        closureDidTouchDown?()
        if (drawAnimation != nil) {
          //  self.resumeLayer(layer: circle)
        }else {
            self.circleAnimation()
            
        }
    }

    @objc func endCircleAnimation(){
        self.pauseLayer(layer: circle)
        closureDidTouchUpInSide?()
        
    }
    func circleAnimation(){

        self.drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        self.drawAnimation?.duration            = duration;
        self.drawAnimation?.repeatCount         = 1.0;
        self.drawAnimation?.fromValue =  0
        self.drawAnimation?.toValue =  1
        self.drawAnimation?.delegate = nil
         self.drawAnimation?.delegate = self
        self.drawAnimation?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        if self.drawAnimation != nil {
             self.circle.add( self.drawAnimation!, forKey: "draw")
        }
             
        
    }
    func reset(layer : CALayer){
         let pausedTime = layer.timeOffset
        layer.speed = 1.0;
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0;
        
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) + pausedTime
        
       
        
        layer.beginTime = timeSincePause;
        
    }
    func pauseLayer(layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0;
        layer.timeOffset = pausedTime;
    }
    func resumeLayer(layer : CALayer){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0;
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0;
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause;
        
    }


    
}
extension LeoLongPressCircle : CAAnimationDelegate{
    func animationDidStart(_ anim: CAAnimation) {

        closureDidStart?()
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        closureDidEnd?()
   
    }
}
