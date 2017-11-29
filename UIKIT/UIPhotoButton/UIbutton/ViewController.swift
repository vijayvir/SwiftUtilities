//
//  ViewController.swift
//  UIbutton
//
//  Created by vijay vir on 8/11/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var btnSinglebutton: UIPhotosButton!

	@IBOutlet weak var btnMultipleImages: UIPhotosButton!

	override func viewDidLoad() {
		super.viewDidLoad()

		btnMultipleImages.closureDidFinishPicking = { (_ images: [String]) -> Void  in

			print(images)
		}

		btnSinglebutton.closureDidFinishPickingAnImage = { images in

			print(images)
		}

		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
