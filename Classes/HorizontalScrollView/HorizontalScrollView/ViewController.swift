//
//  ViewController.swift
//  HorizontalScrollView
//
//  Created by Vijayvir Singh on 20/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
@IBOutlet var pickerView: AKPickerView!
    let titles = ["1", "Kanagawa", "2", "Aichi", "3", "Chiba", "4", "Hokkaido", "5", "Shizuoka"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self

        self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
        self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
        self.pickerView.pickerViewStyle = .wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        // Do any additional setup after loading the view.
    }


}
extension ViewController  : AKPickerViewDataSource, AKPickerViewDelegate {
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
            return self.titles.count
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.titles[item]
    }

    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.titles[item])!
    }

    // MARK: - AKPickerViewDelegate

    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        print("Your favorite city is \(self.titles[item])")
    }
}
