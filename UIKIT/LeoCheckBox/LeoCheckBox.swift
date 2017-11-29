//
//  LeoCheckBox.swift
//  4MEVoiceMailApp
//
//  Created by vijay vir on 11/29/17.
//  Copyright © 2017 Anupriya. All rights reserved.
//

import UIKit
import IBAnimatable

class LeoCheckBox: UIButton {

	@IBInspectable var  selectedImage : UIImage =  #imageLiteral(resourceName: "green_call_icon")

	@IBInspectable var  deSelectedImage : UIImage = #imageLiteral(resourceName: "green_call_icon")

	@IBOutlet weak var imgvIcon: UIImageView?

	@IBOutlet weak var viewBackBround: AnimatableView?
	override var isSelected: Bool {
		willSet {
		}
		didSet {

			if isSelected {

				imgvIcon?.image = selectedImage

				viewBackBround?.animate(AnimationType.pop(repeatCount: 1))

			} else {

	    	imgvIcon?.image = deSelectedImage
         viewBackBround?.animate(AnimationType.pop(repeatCount: 1))

			}

		}
	}
}
