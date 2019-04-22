//
//  ProgressHUD.swift
//  PayFortDemo
//
//  Created by BHOOPENDRA SINGH on 27/12/17.
//  Copyright © 2017 BHOOPENDRA SINGH. All rights reserved.
//

import UIKit
import MBProgressHUD
class Hud: NSObject {
    static let shareInstance = Hud()
    class func show(message:String, view:UIView) {
        let hud  = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = message
    }
    class func hide(view:UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}


