//
//  GerenicViewController.swift
//  Apex
//
//  Created by Nitish Sharma on 09/10/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit

class GenericViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func pop(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func popToConversationsVC(_ sender: UIButton) {
        if (self.navigationController != nil) {
            for vc in  self.navigationController!.viewControllers {
                self.navigationController?.popToViewController(vc, animated: false)
                
                
            }
        }
    }
    @IBAction func dissmiss(_ sender: UIButton) {
        self.dismiss(animated: false) {
        }
    }
    
}

