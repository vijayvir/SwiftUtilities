//
//  ViewController.swift
//  LeoLogMechanism
//
//  Created by Vijayvir Singh on 14/07/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LeoLog.tap(on: self)
        
        LeoLog.write(text: "Some Text \(#function)")
    }
   
    @IBAction func actionWrite(_ sender: Any) {
        LeoLog.write(text: "Some Text \(#function)")
    }
    
}

