//
//  ViewController.swift
//  UIStatePickerTextfield
//
//  Created by vijay vir on 8/17/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var txtState: UIStatePickerTextField!
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		txtState.closureDidSelectState = { country in
			
			print( "closureDidSelectState" , country )
			
		}
		
		txtState.closureEditingDidBegin = { country in
			
			print( "closureEditingDidBegin"  )
			
		}
		
		txtState.closureEditingDidEnd = { country in
			
			print( "closureEditingDidEnd" ,  country)
			
		}
		
		
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}

