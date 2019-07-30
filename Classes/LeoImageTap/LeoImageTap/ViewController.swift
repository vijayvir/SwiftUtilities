//
//  ViewController.swift
//  LeoImageTap
//
//  Created by tecH on 22/07/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit

extension UIImageView {
    
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var load = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView.leoZoom(self)
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if !load {
            load = true
            imageView.leoAddAction(for: .tap) {
                self.imageView.leoZoom( tintColor: .black){
                   
                }
            }
        }
        
    }
    
}

