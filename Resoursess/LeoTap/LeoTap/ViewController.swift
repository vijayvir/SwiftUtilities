//
//  ViewController.swift
//  LeoTap
//
//  Created by Vijayvir Singh on 31/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//



import Foundation
import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var btnTap: UIButton!
    @IBOutlet weak var viewFirst: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let some = ["Value1": "Vijayvir"]
        btnTap.leoTap(element: some) { (element) in
            if let some1 = element as? [String : Any] {
                print(some1)
            }
        }
        imageview.leoTap(element: ["First","Second"]) { (element) in
            if let some = element as? [String] {
                print(some)
            }
        }
        label.leoTap(element: ["First","Second"]) { (element) in
            if let some = element as? [String] {
                print(some)
            }
        }
        viewFirst.leoTapView(element: ["String" : 23]) { (e ) in
            print(e)
        }
        // Do any additional setup after loading the view.
    }


}

