//
//  ViewController.swift
//  LeoRegex
//
//  Created by vijay vir on 10/30/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

//"^([0-9]+).([0-9]{0,2})$"
		if "23.52" =^ LeoRegex.LeoRegexType.numberDecimal.pattern {
       print("Is have alphabets.")
		} else {
      print("Is not  have alphabets.")
		}
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

