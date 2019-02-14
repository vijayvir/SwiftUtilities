 //
//  LeoHud.swift
//  MedicalApp
//
//  Created by Apple on 28/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit

import MBProgressHUD

class LeoHud: NSObject {
    class func show(message: String = "Processing...", delegate: UIViewController, mode: MBProgressHUDMode = MBProgressHUDMode.indeterminate) {
        var load: MBProgressHUD = MBProgressHUD()

        load = MBProgressHUD.showAdded(to: delegate.view, animated: true)

        load.mode = mode

        if message.characters.count > 0 {
            load.label.text = message
        }

        //        case indeterminate
        //
        //        /// A round, pie-chart like, progress view.
        //        case determinate
        //
        //        /// Horizontal progress bar.
        //        case determinateHorizontalBar
        //
        //        /// Ring-shaped progress view.
        //        case annularDeterminate
        //
        //        /// Shows a custom view.
        //        case customView
        //
        //        /// Shows only labels.
        //        case text
        //

        UIApplication.shared.isNetworkActivityIndicatorVisible = true

    }

    class func hide(delegate: UIViewController) {

			DispatchQueue.main.async {

            MBProgressHUD.hide(for: delegate.view, animated: true)

					UIApplication.shared.isNetworkActivityIndicatorVisible = false

        }

    }
}
