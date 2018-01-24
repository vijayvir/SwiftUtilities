//
//  File.swift

//
//  Created by Anupriya on 22/01/18.
//  Copyright © 2018 vijay vir. All rights reserved.
//

import Foundation
import UIKit

class LeoCarModelTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerView: UIPickerView = UIPickerView()
    var carModel : [LeoCarModel.ModelDetails] = []
    //var carColors:  [CarColorType] = CarColor.CarColors()
    // Use this class to have single image.
    public  var closureDidSelectCarModel: ((_ subcategory: LeoCarModel.ModelDetails) -> Void)?
    
    
    func configure(carModels : [LeoCarModel.ModelDetails]) {
        carModel = carModels
        
        if carModel.count <= 0 {
            self.isEnabled = false
        }else {
            self.isEnabled = true
        }
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            
            if carModel.count > 0 {
                let carModelType: LeoCarModel.ModelDetails = carModel[index]
                self.text = carModelType.modelName
            }
            
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        addInputAccessoryView()
        
        self.inputView = pickerView
        self.textColor = .white
        //self.textColor = AppColor.theme.color
        pickerView.dataSource = self
        
        pickerView.delegate = self
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        if carModel.count <= 0 {
            self.isEnabled = false
        }else {
            self.isEnabled = true
        }
        
        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            
            if carModel.count > 0 {
                let carModelType: LeoCarModel.ModelDetails = carModel[index]
                self.text = carModelType.modelName
            }
            
        }
        
    }
    
    func addInputAccessoryView() {
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        
        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        var arraybutton: [UIBarButtonItem] = []
        
        // arraybutton.append(donebutton)
        
        arraybutton.append(space)
        
        arraybutton.append(donebutton)
        
        toolbar.setItems(arraybutton, animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        print("\(String(describing: self.inputAccessoryView))")
    }
    deinit {
        
    }
    
    @objc func menuButtonTapped(sender _: UIBarButtonItem) {
        
        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            
            let carModelType: LeoCarModel.ModelDetails = carModel[index]
            
            self.text = carModelType.modelName
            closureDidSelectCarModel?(carModelType)
            
            
        }
        
        _ = resignFirstResponder()
        
    }
    
    func pickerTextFieldEditingDidEnd(_: UITextField) {
        
    }
    
    // MARK: PickerViewDelegate
    public func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return carModel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let carModelType: LeoCarModel.ModelDetails = carModel[row]
        return carModelType.modelName
    }
    
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        let carModelType: LeoCarModel.ModelDetails = carModel[row]
        self.text = carModelType.modelName
        closureDidSelectCarModel?(carModelType)
        
    }
    
    
}
