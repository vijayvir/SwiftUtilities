//
//  SkyFloatingLabelDatePickerTextField.swift
//
//
//  Created by Apple on 22/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit

enum LeoUITimePickerTextFieldDateFormatType {

	case hhmmss
	
	case EEEhhmmss

	case EEEEHHmmss
	
	var format: String {
		
		switch self {
			
		case .hhmmss: return "hh:mm:ss"
			
		case .EEEhhmmss: return "EEE hh:mm:ss"
			
		case .EEEEHHmmss : return "EEEE HH:mm:ss"
		}
		
	}
	
}

class LeoUITimePickerTextField: UITextField {
	
    // MARK: Outlets

    // MARK: Variables

    var datePicker: UIDatePicker = UIDatePicker()

	  @IBInspectable var uiDateFormat: String = LeoUITimePickerTextFieldDateFormatType.EEEEHHmmss.format
	
    @IBInspectable var serverDateFormat: String = LeoUITimePickerTextFieldDateFormatType.EEEhhmmss.format

	  @IBInspectable var leoTag: Int = 20

	  var closureEditingDidBegin : ((String) -> Void)?
	
	  var closureValueChanged : ((String) -> Void)?
	
	  var closureEditingDidEnd : ((String) -> Void)?
	
    // MARK: CLC

    override func awakeFromNib() {
			
        super.awakeFromNib()
			
    }

    required init?(coder aDecoder: NSCoder) {
			
			super.init(coder: aDecoder)

			addInputAccessoryView()

			self.addTarget(self, action: #selector(LeoUITimePickerTextField.pickerTextFieldEditingDidBegin(_:)), for: UIControlEvents.editingDidBegin)

			self.addTarget(self, action: #selector(LeoUITimePickerTextField.pickerTextFieldEditingDidEnd(_:)), for: UIControlEvents.editingDidEnd)

			datePicker.datePickerMode = .time

			datePicker.tag = leoTag

			datePicker.locale = Locale(identifier: "en_US")

			datePicker.addTarget(self, action: #selector(LeoUITimePickerTextField.pickerTextFieldValueChanged(_:)), for: .valueChanged)

			self.inputView = datePicker


    }

	// MARK: Actions

	// MARK: Functions

}


// MARK: Public methods

extension LeoUITimePickerTextField {
	
	func setDate(date:Date , animated : Bool = false ){
		
		datePicker.setDate(date, animated: animated)
		
		self.pickerTextFieldValueChanged(self)
		
		
	}
}

// MARK: inputAccessoryView

extension LeoUITimePickerTextField {

	func addInputAccessoryView() {

		let toolbar = UIToolbar()

		toolbar.sizeToFit()

		let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tapOnDone(sender:)))
		
		let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		let currentDateButton = UIBarButtonItem(title: "Current", style: .done, target: self, action: #selector(tapOnCurrentDate(sender:)))

		var barbuttons: [UIBarButtonItem] = []

		barbuttons.append(currentDateButton)
		
		barbuttons.append(space)

		barbuttons.append(doneButton)

		toolbar.setItems(barbuttons, animated: true)

		self.inputAccessoryView = toolbar

	}

	func tapOnDone(sender _: UIBarButtonItem) {

		_ = resignFirstResponder()

	}
	
	func tapOnCurrentDate(sender _: UIBarButtonItem) {
		
   	self.setDate(date: Date(), animated: true)
		
	}
}

// MARK:  UIControls States

extension LeoUITimePickerTextField {

	@objc func pickerTextFieldEditingDidBegin(_ textFieldTemp: UITextField) {
		
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

	
	func pickerTextFieldValueChanged(_ textFieldTemp: UITextField) {

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
	
	func pickerTextFieldEditingDidEnd(_ textFieldTemp: UITextField) {
		
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
