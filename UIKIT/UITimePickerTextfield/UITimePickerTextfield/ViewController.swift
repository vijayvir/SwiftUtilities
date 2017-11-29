//
//  ViewController.swift
//  UITimePickerTextfield
//
//  Created by vijay vir on 8/16/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var txtTimePicker: LeoUITimePickerTextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		txtTimePicker.closureValueChanged = {
			time in 
			
			print(time)
			
		}
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

