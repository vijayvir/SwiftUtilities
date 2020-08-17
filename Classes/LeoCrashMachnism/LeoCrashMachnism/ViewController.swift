//
//  ViewController.swift
//  LeoCrashMachnism
//
//  Created by Vijayvir Singh on 01/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func actionCrash(_ sender: UIButton) {
        
        LeoCrash.kill()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

