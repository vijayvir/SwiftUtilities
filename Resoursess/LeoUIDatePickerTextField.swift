//
//  SkyFloatingLabelDatePickerTextField.swift
//
//
//  Created by Apple on 22/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit
class LeoUIDatePickerTextField: UITextField {
    
    enum Format {
        case yyyyMMdd
        case ddMMyyyy
        case ddMMMMyyyy
        
        case hhmmss
        case EEEhhmmss
        case EEEEHHmmss
        
        
        var format: String {
            
            switch self {
                
            case .yyyyMMdd: return "yyyy-MM-dd"
                
            case .ddMMyyyy: return "dd-MM-yyyy"
                
            case .ddMMMMyyyy : return "dd-MMMM-yyyy"
                
            case .hhmmss: return "hh:mm:ss"
                
            case .EEEhhmmss: return "EEE hh:mm:ss"
                
            case .EEEEHHmmss : return "EEEE HH:mm:ss"
            }
            
        }
        
    }
    enum Mode : Int {
        case time = 1
        case date = 2
        case dateTime = 3
    }
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    @IBInspectable var uiDateFormat: String = Format.yyyyMMdd.format
    
    @IBInspectable var serverDateFormat: String = Format.yyyyMMdd.format
    
    @IBInspectable var leoTag: Int = 4
    
    @IBInspectable var mode: Int = Mode.date.rawValue
    
    
    var closureEditingDidBegin : ((String) -> Void)?
    
    var closureValueChanged : ((String) -> Void)?
    
    var closureEditingDidEnd : ((String) -> Void)?
    
    // MARK: CLC
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        if mode == Mode.time.rawValue {
            datePicker.datePickerMode = .time
            
        } else if mode == Mode.date.rawValue {
            datePicker.datePickerMode =  .date
        } else if mode == Mode.dateTime.rawValue {
            datePicker.datePickerMode =  .dateAndTime
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        addInputAccessoryView()
        
        self.addTarget(self, action: #selector(LeoUIDatePickerTextField.pickerTextFieldEditingDidBegin(_:)), for: UIControl.Event.editingDidBegin)
        
        self.addTarget(self, action: #selector(LeoUIDatePickerTextField.pickerTextFieldEditingDidEnd(_:)), for: UIControl.Event.editingDidEnd)
        
        if mode ==  Mode.time.rawValue {
            datePicker.datePickerMode = .time
            
        } else if mode ==  Mode.date.rawValue {
            datePicker.datePickerMode =  .date
        } else if mode ==  Mode.dateTime.rawValue {
            datePicker.datePickerMode =  .dateAndTime
        }
        
        
        
        datePicker.tag = leoTag
        
        datePicker.locale = Locale(identifier: "en_US")
        
        datePicker.addTarget(self, action: #selector(LeoUIDatePickerTextField.pickerTextFieldValueChanged(_:)), for: .valueChanged)
        
        self.inputView = datePicker
        
        
    }
    
    // MARK: Actions
    
    // MARK: Functions
    
}


// MARK: Public methods

extension LeoUIDatePickerTextField {
    
    func setDate(date:Date , animated : Bool = false ){
        
        datePicker.setDate(date, animated: animated)
        
        self.pickerTextFieldValueChanged(self)
        
        
    }
}

// MARK: inputAccessoryView

extension LeoUIDatePickerTextField {
    
    func addInputAccessoryView() {
        
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tapOnDone(sender:)))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let currentDateButton = UIBarButtonItem(title: "Today", style: .done, target: self, action: #selector(tapOnCurrentDate(sender:)))
        
        var barbuttons: [UIBarButtonItem] = []
        
        barbuttons.append(currentDateButton)
        
        barbuttons.append(space)
        
        barbuttons.append(doneButton)
        
        toolbar.setItems(barbuttons, animated: true)
        
        self.inputAccessoryView = toolbar
        
    }
    
    @objc func tapOnDone(sender _: UIBarButtonItem) {
        
        _ = resignFirstResponder()
        
    }
    
    @objc func tapOnCurrentDate(sender _: UIBarButtonItem) {
        
        self.setDate(date: Date(), animated: true)
        
    }
}

// MARK:  UIControls States

extension LeoUIDatePickerTextField {
    
    @objc  func pickerTextFieldEditingDidBegin(_ textFieldTemp: UITextField) {
        
        
        
        let  dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = uiDateFormat
        
        if let date = dateFormatter.string(from: datePicker.date) as  String? {
            
            self.text = "\(date)"
            
        } else {
            
            self.text = "\( datePicker.date)"
        }
        
        
        dateFormatter.dateFormat = serverDateFormat
        
        if let date = dateFormatter.string(from: datePicker.date) as  String? {
            
            closureEditingDidBegin?("\( date)")
            
        } else {
            
            closureEditingDidBegin?("\( datePicker.date)")
        }
        
        
        
        
    }
    
    
    @objc func pickerTextFieldValueChanged(_ textFieldTemp: UITextField) {
        
        let  dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = uiDateFormat
        
        if let date = dateFormatter.string(from: datePicker.date) as  String? {
            
            self.text = "\(date)"
            
        } else {
            
            self.text = "\( datePicker.date)"
        }
        
        dateFormatter.dateFormat = serverDateFormat
        
        if let date = dateFormatter.string(from: datePicker.date) as  String? {
            
            closureValueChanged?("\( date)")
            
        } else {
            
            closureValueChanged?("\( datePicker.date)")
        }
        
    }
    
    @objc func pickerTextFieldEditingDidEnd(_ textFieldTemp: UITextField) {
        
        let  dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = uiDateFormat
        
        if let date = dateFormatter.string(from: datePicker.date) as  String? {
            
            self.text = "\(date)"
            
        } else {
            
            self.text = "\( datePicker.date)"
            
        }
        
        
        dateFormatter.dateFormat = serverDateFormat
        
        if let date = dateFormatter.string(from: datePicker.date) as  String? {
            
            closureEditingDidEnd?("\( date)")
            
        } else {
            
            closureEditingDidEnd?("\( datePicker.date)")
        }
    }
}
