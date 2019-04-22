//
//  LeoAlertViewController.swift
//  UIMultiplePhotos
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//
import Foundation
import UIKit


let appNameAlert = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String


class Alert: UIAlertController {
    class func showSimple(_ message: String, completionHandler: (() -> Swift.Void)? = nil) {
        let keywindow = UIApplication.shared.keyWindow
       // let mainController = keywindow?.rootViewController
        let alert = UIAlertController(title: appNameAlert, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
            print("Heloo ")
            completionHandler?()
        }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: {
        })
        
    }
    
    // make sure you have navigation  view controller
    
    class func showComplex(title: String? = "",
                         message: String,
                         preferredStyle: UIAlertController.Style? = .alert,
                         cancelTilte: String,
                         otherButtons: String ...,
        comletionHandler: ((Swift.Int) -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)
        
        for i in otherButtons {
            //  print( UIApplication.topViewController() ?? i  )
            
            alert.addAction(UIAlertAction(title: i, style: UIAlertAction.Style.default,
                                          handler: { (action: UIAlertAction!) in
                                            
                                            comletionHandler?(alert.actions.index(of: action)!)
                                            
            }
            ))
            
        }
        if (cancelTilte as String?) != nil {
            alert.addAction(UIAlertAction(title: cancelTilte, style: UIAlertAction.Style.destructive,
                                          handler: { (action: UIAlertAction!) in
                                            
                                            comletionHandler?(alert.actions.index(of: action)!)
                                            
            }
            ))
        }
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: {
            
        })
        
    }
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        // need R and d
        //        if let top = UIApplication.shared.delegate?.window??.rootViewController
        //        {
        //            let nibName = "\(top)".characters.split{$0 == "."}.map(String.init).last!
        //
        //            print(  self,"    d  ",nibName)
        //
        //            return top
        //        }
        return controller
    }
}
