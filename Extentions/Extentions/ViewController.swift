//
//  ViewController.swift
//  Extentions
//
//  Created by vijay vir on 9/8/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



	@IBOutlet weak var txtEmail: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()

		  print(" Have Value  Title " )


		guard let titlee = txtEmail.text else {

			// Alert: textField is empty!
			return
		}


		var  someString : String? = ""

          someString = nil






    txtEmail.text =   someString.isEmptyString()



		let stuff = ["nate", "", nil, "loves", nil, "swift", ""]


		let a = stuff.map { $0.nilIfEmpty }

		print(a) // [Optional("nate"), nil, nil, Optional("loves"), nil, Optional("swift"), nil]

		let b = stuff.flatMap { $0.nilIfEmpty }

		print(b) // ["nate", "loves", "swift"]


		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

