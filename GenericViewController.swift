//
//  GenericViewController.swift
//  MedicalApp
//
//  Created by Apple on 15/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit

let appNameAlertGeneric = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
class GenericViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: “orientation”)
    //    }
    //    override func shouldAutorotate() -> Bool {
    //        // Lock autorotate
    //        return false
    //    }
    //
    //    override func supportedInterfaceOrientations() -> Int {
    //
    //        // Only allow Portrait
    //        return Int(UIInterfaceOrientationMask.landscapeLeft.rawValue)
    //    }
    //
    //    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
    //
    //        // Only allow Portrait
    //        return UIInterfaceOrientation.landscapeLeft
    //    }
    @IBAction func actionBack(_: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(_ message: String, on: UIViewController, completionHandler: (() -> Swift.Void)? = nil) {
        let keywindow = UIApplication.shared.keyWindow
        _ = keywindow?.rootViewController
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "\(appNameAlertGeneric)", message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
                
                print("Heloo ")
                
                completionHandler?()
                
            }))
            
            on.present(alert, animated: true, completion: {
            })
            
        }
        
    }
    
    func showAlert(_ message: String, completionHandler: (() -> Swift.Void)? = nil) {
        
        DispatchQueue.main.async {
            let keywindow = UIApplication.shared.keyWindow
            let mainController = keywindow?.rootViewController
            let alert = UIAlertController(title: "\(appNameAlertGeneric)", message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
                
                print("Heloo ")
                
                completionHandler?()
                
            }))
            
            mainController?.present(alert, animated: true, completion: {
                
            })
            
        }
        
    }
    
}
