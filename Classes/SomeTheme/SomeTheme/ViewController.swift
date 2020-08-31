//
//  ViewController.swift
//  SomeTheme
//
//  Created by Vijayvir Singh on 04/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSetting: UIButton!
    
    @IBOutlet weak var imageViewBackGround: UIImageView!
    @IBOutlet weak var txtField: LeoAnyElementTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.configure(withElements: [ModelDetails(),ModelDetails(), GreenTheme(), RedTheme()])
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: NSNotification.Name("ThemeChange"), object: nil)
        
        txtField.closureDidSelectElement = { (element, slectedBy) in
            
            if let elememt1 = element as? Theme {
               ThemeProvider.currentTheme = elememt1
                NotificationCenter.default.post(name: NSNotification.Name("ThemeChange"), object: nil)
            }
            
        }
        applyTheme()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func actionTap(_ sender: Any) {
        
        if ThemeProvider.currentTheme is StockDarkTheme {
            ThemeProvider.currentTheme  = StockLightTheme()
        }else {
            ThemeProvider.currentTheme  = StockDarkTheme()
        }
        NotificationCenter.default.post(name: NSNotification.Name("ThemeChange"), object: nil)
    }
}
extension  ViewController : ThemeViemProtocol {
   @objc func applyTheme() {
       
    self.view.backgroundColor = ThemeProvider.currentTheme.primaryColor
    btnSetting.tintColor = ThemeProvider.currentTheme.primaryPlaceholderColor
    btnSetting.setTitleColor(ThemeProvider.currentTheme.primaryPlaceholderColor, for: .normal)
    
    imageViewBackGround.image = ThemeProvider.currentTheme.backGroundImage
    }
    
    
}
