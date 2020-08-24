//
//  ViewController.swift
//  LeoPopOver
//
//  Created by Vijayvir Singh on 21/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func actionTap(_ sender: UIButton) {
        
        let vcSome = self.storyboard?.instantiateViewController(withIdentifier: "V2ViewController") as! V2ViewController
        let some = LeoPopOver()
        let osme = some.prepareNCWith(content: vcSome,
        contentSize : .size(size: CGSize(width: 100, height: 100)),
        sourceView: sender,
        sourceRect: sender.bounds)
        self.present(osme!, animated: true, completion: {})
        
    }
    

}

