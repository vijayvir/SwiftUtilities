//
//  ViewController.swift
//  LeoAnySelectableTextFieldDemo
//
//  Created by tecH on 12/07/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit

class Employee {
    
    var name : String = "Viajyvirtgfrgtk wiruhyiuew yuiryui eywuiry eiuwwyriuyeiuwyr iuwyeuiryiu eyi "
    var department  : String = "Iphonrew reiuw hruiehwuirhy iuewyuiry uieywruiy iuewyriu eywiue"
    var leoIsSelected : Bool = false
    
    
}
extension Employee : LeoSelectable {
  
    
    var leoTitle: String {
        return name
    }
    
    var leoDetailText: String? {
        return department
    }
    var leoImage: UIImage? {
        if name == "Naman" {
               return  nil
        }
        
        return  #imageLiteral(resourceName: "someImages")
    }
    
    
    
    
}




class ViewController: UIViewController {

    @IBOutlet weak var txtField2: LeoAnySelectableTextField!
    override func viewDidLoad() {
        
        let first = Employee()
        let second = Employee()
        second.leoIsSelected = true
        let third = Employee()
        let first1 = Employee()
        let second1 = Employee()
        let third1 = Employee()
        third1.name = "Naman"
        
        txtField2.configure(withElements: [first , second , third  , first1 , second1 , third1])
            .withClosureDidSelectElements { (elements) in
            
                let osme = elements.reduce("", { (result, elemeent) -> String in
                    
                    return result +  "," + elemeent.leoTitle
                })
                
                self.txtField2.text = osme
                
            print(elements.count)
        
            }.withStop()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    
    }

}

