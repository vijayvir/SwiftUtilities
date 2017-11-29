//
//  ViewController.swift
//  UIPickerDateTextfield
//
//  Created by vijay vir on 8/16/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var txtDate: LeoUIDatePickerTextField!
	
	override func viewDidLoad() {

		super.viewDidLoad()
		
		txtDate.closureEditingDidBegin = { date in
			
			print("Some thing is closureEditingDidBegin" , date)
			
		}
		
		txtDate.closureValueChanged = { date in
			
			print("Some thing is changed" , date)
			
			
		}
		
		txtDate.closureEditingDidEnd = { 	date in
			
			print("Some thing is closureEditingDidEnd" , date)
			
		}

	}

	@IBAction func actionCurrentDate(_ sender: UIButton) {
		
		txtDate.setDate(date: Date(), animated: true)
	}
	override func didReceiveMemoryWarning() {

		super.didReceiveMemoryWarning()

		// Dispose of any resources that can be recreated.
	}

}
