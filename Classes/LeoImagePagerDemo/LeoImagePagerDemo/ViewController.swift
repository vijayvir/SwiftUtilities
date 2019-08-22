//
//  ViewController.swift
//  LeoImagePagerDemo
//
//  Created by tecH on 19/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit
class Some {
    
    var value : UIImage
    init(value : UIImage ) {
        self.value = value
  
    }
}
extension Some :  LeoImagePagerElementable {
    var leoImage: UIImage {
        return value
    }
    
    
}

class ViewController: UIViewController {

    @IBOutlet weak var viewPager: LeoImagePagerView!
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        viewPager.configure(elements: [Some(value: #imageLiteral(resourceName: "CanvasHor")),
                                       Some(value: #imageLiteral(resourceName: "Screenshot 2019-08-19 at 9.59.37 AM")) ,
                                       Some(value: #imageLiteral(resourceName: "Screenshot 2019-08-19 at 12.17.36 PM")) ,
                                       Some(value: #imageLiteral(resourceName: "CanvasHor")) ,
                                       Some(value: #imageLiteral(resourceName: "Screenshot 2019-08-19 at 12.17.36 PM"))] ) {
            
        }
        // Do any additional setup after loading the view.
    }

}

