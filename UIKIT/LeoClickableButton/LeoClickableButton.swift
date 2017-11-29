//
//  LeoClickableButton.swift
//  ShopOrSell
//
//  Created by vijay vir on 10/25/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit
import IBAnimatable

class LeoClickableButton: AnimatableButton {
	open override func layoutSubviews() {
		super.layoutSubviews()
	}
	 override func prepareForInterfaceBuilder(){
        super.prepareForInterfaceBuilder()
	}

	override var isHighlighted: Bool {
		didSet {

			// print("Some things is been highlighted " , isHighlighted)

			if (isHighlighted) {

				shadowOpacity = 0

			} else {

				shadowOpacity = 1

			}
		}
	}


}

