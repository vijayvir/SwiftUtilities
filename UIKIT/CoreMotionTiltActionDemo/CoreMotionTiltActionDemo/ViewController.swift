//
//  ViewController.swift
//  CoreMotionTiltActionDemo
//
//  Created by Anupriya on 13/10/17.
//  Copyright © 2017 Anupriya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {	
   
    @IBOutlet weak var viewToShift: UIView!
    @IBOutlet weak var viewToTilt: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewToShift.leoUIMotionEffect(strength: 40)
        
        viewToTilt.leoUITiltMotionEffect(strength: 1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


