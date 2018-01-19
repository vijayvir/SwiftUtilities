//
//  LeoArcView.swift
//  ProjectTimer
//
//  Created by vijay vir on 1/19/18.
//  Copyright © 2018 vijay vir. All rights reserved.
//
import Foundation
import UIKit
@IBDesignable
class LeoArcProgressBar: UIView {
	var startPoint: CGFloat = 0
	@IBInspectable var color: UIColor = UIColor.yellow
	@IBInspectable var trackColor: UIColor = UIColor.gray
	@IBInspectable var trackWidth: CGFloat = 1
	@IBInspectable var fillPercentage: CGFloat = 100

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clear
	} // init
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		self.backgroundColor = UIColor.clear
	} // init

	override func draw(_ rect: CGRect) {
		// first we want to find the centerpoint and the radius of our rect
		let center: CGPoint = CGPoint(x: rect.midX, y: rect.midY)

		let radius: CGFloat = rect.width / 2

		// make sure our track width is at least 1

		if ( 1 > self.trackWidth) {
			self.trackWidth = 1
		} // if
		// and our track width cannot be greater than the radius of our circle
		if ( radius < self.trackWidth ) {
			self.trackWidth = radius
		} // if
		// we need our graph starting and ending points
	//	let (graphStartingPoint, graphEndingPoint) = self.getGraphStartAndEndPointsInRadians()
		// now we need to first draw the track...

		    let π: CGFloat = .pi

		let startPoint: CGFloat = ((CGFloat(120) * π) / 180)

		let endPoint: CGFloat =  ((CGFloat(420) * π) / 180)

  print(startPoint , endPoint)

		let trackPath = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: startPoint, endAngle: endPoint, clockwise: true)
		trackPath.lineWidth = trackWidth
		trackPath.lineCapStyle = .round
		self.trackColor.setStroke()
		trackPath.stroke()

   let someAngle =  (3 * fillPercentage ) + 120

		let endPointPercentage: CGFloat =  ((CGFloat( someAngle  ) * π) / 180)
		let percentagePath = UIBezierPath(arcCenter: center, radius: radius - (trackWidth / 2), startAngle: startPoint, endAngle: endPointPercentage, clockwise: true)
		percentagePath.lineWidth = trackWidth
		percentagePath.lineCapStyle = .round
		self.color.setStroke()
		percentagePath.stroke()
		return
}
}


//private func getGraphStartAndEndPointsInRadians() -> (graphStartingPoint: CGFloat, graphEndingPoint: CGFloat) {
//	// make sure our starting point is at least 0 and less than 100
//	if ( 0 > self.startPoint ) {
//		self.startPoint = 0
//	} else if ( 100 < self.startPoint ) {
//		self.startPoint = 100
//	} // if
//	// make sure our fill percentage is at least 0 and less than 100
//	if ( 0 > self.fillPercentage ) {
//		self.fillPercentage = 0
//	} else if ( 100 < self.fillPercentage ) {
//		self.fillPercentage = 100
//	} // if
//	// we take 25% off the starting point, so that a zero starting point
//	// begins at the top of the circle instead of the right side...
//	self.startPoint = self.startPoint - 25
//	// we calculate a true fill percentage as we need to account
//	// for the potential difference in starting points
//	let trueFillPercentage = self.fillPercentage + self.startPoint
//
//	let π: CGFloat = .pi
//
//	// now we can calculate our start and end points in radians
//	let startPoint: CGFloat = ((2 * π) / 100) * (CGFloat(self.startPoint))
//	let endPoint: CGFloat = ((2 * π) / 100) * (CGFloat(trueFillPercentage))
//
//	return(startPoint, endPoint)
//
//} // func

