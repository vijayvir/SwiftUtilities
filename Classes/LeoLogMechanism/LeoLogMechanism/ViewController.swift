//
//  ViewController.swift
//  LeoLogMechanism
//
//  Created by Vijayvir Singh on 14/07/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import UIKit

class LeoLog : NSObject{
    static var shared = LeoLog()
    var vc : UIViewController?
    static func tap(on : UIViewController) {
        let tap = UITapGestureRecognizer(target: LeoLog.shared, action: #selector(LeoLog.shared.handleTap(_:)))
              tap.numberOfTapsRequired = 3
              on.view.addGestureRecognizer(tap)
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("Log.txt")
        print(dataPath.absoluteString)
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
             
                
            } catch {
                print(error.localizedDescription);
            }
            
        }
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
           // handling code
           print("Some Things is to done here.")
       }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LeoLog.tap(on: self)
    }
   

}

