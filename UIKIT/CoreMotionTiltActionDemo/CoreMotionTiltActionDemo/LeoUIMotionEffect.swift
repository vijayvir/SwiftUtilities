//
//  LeoUIMotionEffect.swift
//  CoreMotionTiltActionDemo
//
//  Created by vijay vir on 10/13/17.
//  Copyright © 2017 Anupriya. All rights reserved.
//
// Link:
import Foundation
import UIKit

// source - http://szulctomasz.com/2015/08/10/ios-using-uimotioneffect-to-add-perspective-to-a-view.html

extension UIView {
	 func leoUIMotionEffect(strength: Float) {
    self.addMotionEffect(UIMotionEffect.leoTwoAxesShift(strength: strength))
	}
    
    func leoUITiltMotionEffect(strength: Float){
    
        self.addMotionEffect(UIMotionEffect.twoAxesTilt(strength: strength))
        
    }
}
extension UIMotionEffect {

	class func leoTwoAxesShift(strength: Float) -> UIMotionEffect {
		// internal method that creates motion effect
		func motion(type: UIInterpolatingMotionEffectType) -> UIInterpolatingMotionEffect {
			let keyPath = type == .tiltAlongHorizontalAxis ? "center.x" : "center.y"
			let motion = UIInterpolatingMotionEffect(keyPath: keyPath, type: type)
			motion.minimumRelativeValue = -strength
			motion.maximumRelativeValue = strength
			return motion
		}

		// group of motion effects
		let group = UIMotionEffectGroup()
		group.motionEffects = [
			motion(type: .tiltAlongHorizontalAxis),
			motion(type: .tiltAlongVerticalAxis)
		]
		return group
	}

    class func twoAxesTilt(strength: Float) -> UIMotionEffect {
        // get relative change with `strength` passed to the main method.
        func relativeValue(isMax: Bool, type: UIInterpolatingMotionEffectType) -> NSValue {
            var transform = CATransform3DIdentity
            transform.m34 = (1.0 * CGFloat(strength)) / 2000.0
            
            let axisValue: CGFloat
            if type == .tiltAlongVerticalAxis {
                // transform vertically
                axisValue = isMax ? -1.0 : 1.0
                transform = CATransform3DRotate(transform, axisValue * CGFloat(Double.pi / 4), 1, 0, 0)
            } else {
                // transform horizontally
                axisValue = isMax ? 1.0 : -1.0
                transform = CATransform3DRotate(transform, axisValue * CGFloat(Double.pi / 4), 0, 1, 0)
            }
            return NSValue(caTransform3D: transform)
        }
        
        // create motion for specified `type`.
        func motion(type: UIInterpolatingMotionEffectType) -> UIInterpolatingMotionEffect {
            let motion = UIInterpolatingMotionEffect(keyPath: "layer.transform", type: type)
            motion.minimumRelativeValue = relativeValue(isMax: false, type: type)
            motion.maximumRelativeValue = relativeValue(isMax: true, type: type)
            return motion
        }
        
        // create group of horizontal and vertical tilt motions
        let group = UIMotionEffectGroup()
        group.motionEffects = [
            motion(type: .tiltAlongHorizontalAxis),
            motion(type: .tiltAlongVerticalAxis)
        ]
        return group
    }

}
