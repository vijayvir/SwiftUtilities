//
//  ViewController.swift
//  MovCanvas
//
//  Created by vijayvir on 09/09/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewShape: BusCanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewShape.configure()
    }

    

}

