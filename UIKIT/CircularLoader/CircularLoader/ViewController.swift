//
//  ViewController.swift
//  CircularLoader
//
//  Created by tecH on 07/06/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewSome: LeoLongPressCircle!
    @IBOutlet weak var btnAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSome.configure() .withDidEnd({
                print("Ended")
            }) .withDidStart({
                print("Start")
            }) .withDidTouchUpInSide({
                print("withDidTouchUpInSide")
            }).withDidTouchDown({
                    print("withDidTouchUpInSide")
            })
            .run()
        // Do any additional setup after loading the view.
    }


}

