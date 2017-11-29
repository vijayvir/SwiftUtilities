//
//  UIStatePickerTextfield.swift
//  UIStatePickerTextfield
//
//  Created by vijay vir on 8/17/17.
//  Created by Anupriya on 16/08/17.
//  Copyright © 2017 Anupriya. All rights reserved.
//

import UIKit

import Foundation

import CoreLocation

struct India{
	
	struct State{
		
		var stateName: Any?
		
		var shortName: Any?
		
		var capital: Any?
		
		var lat: Any?
		
		var long: Any?
		
		
		var latLong: CLLocationCoordinate2D
		{
			
			if let  latitude = lat as?  String,  let  logitude = long as?  String {
				
				let latDouble  : Double = Double( latitude  ) ?? 0
				
				let longtDouble  : Double = Double( logitude  ) ?? 0
				
				return CLLocationCoordinate2D(latitude: latDouble, longitude: longtDouble)
			}
			
			return CLLocationCoordinate2D(latitude: 0, longitude: 0)
		}
		
	}
	
	var states: [State] = []
	
	
	
	init(){
		
		let object = leoReadDataFromCSV(bunldePath: "States - Sheet1", extention: "csv")
		
		if var states = object as? [Any] {
			
			states.remove(at: 0)
			
			for tempState in states {
				
				if let state = tempState as? [Any] {
					
					if state.count == 5 {
						
						let statee :India.State = India.State(stateName: state[0] ,
						                                      shortName: state[1] ,
						                                      capital: state[2] ,
						                                      lat: state[3] ,
						                                      long: state[4])
						
						self.states.append(statee)
					}
			
					
					
				}
			}
		}
		
	}
}
class UIStatePickerTextField: UITextField{
	
	
	var pickerView: UIPickerView = UIPickerView()
	
	var india : India = India()
	
	public  var closureDidSelectState: ((_ state: India.State ) -> Void)?
	
	var closureEditingDidBegin : ((_ state: India.State) -> Void)?
	
	var closureValueChanged : ((_ state: India.State) -> Void)?
	
	var closureEditingDidEnd : ((_ state: India.State) -> Void)?
	
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		
		self.addTarget(self, action: #selector(UIStatePickerTextField.pickerTextFieldEditingDidBegin(_:)), for: UIControlEvents.editingDidBegin)
		
		self.addTarget(self, action: #selector(UIStatePickerTextField.pickerTextFieldEditingDidEnd(_:)), for: UIControlEvents.editingDidEnd)
		
		self.inputView = pickerView
		
		pickerView.dataSource = self
		
		pickerView.delegate = self
		
		
		if india.states.count > 0 {
			
			pickerView.selectRow(0, inComponent: 0, animated: true)
			
			if let index = pickerView.selectedRow(inComponent: 0) as Int? {
				
				let country: India.State = india.states[index]
				
				self.text = "\(String(describing: country.stateName!))"
			}
		}
		
		
		
		addInputAccessoryView()
	}
	
	
	func addInputAccessoryView() {
		let toolbar = UIToolbar()
		
		toolbar.sizeToFit()
		
		let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done(sender:)))
		
		let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		
		var arraybutton: [UIBarButtonItem] = []
		
		arraybutton.append(donebutton)
		
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
	
	func done(sender _: UIBarButtonItem) {
		
		if let index = pickerView.selectedRow(inComponent: 0) as Int? {
			
			let country: India.State = india.states[index]
			
			self.text = "\(String(describing: country.stateName!))"
			
			closureDidSelectState?(country)
		}
		
		_ = resignFirstResponder()
		
	}
	
	
}


extension UIStatePickerTextField {
	
	func pickerTextFieldEditingDidBegin(_ textFieldTemp: UITextField) {
		
		
		
		if let index = pickerView.selectedRow(inComponent: 0) as Int? {
			
			let country: India.State = india.states[index]
			
			self.text = "\(String(describing: country.stateName!))"
			
			closureEditingDidBegin?(country)
		}
		
		
		
	}
	
	func pickerTextFieldValueChanged(_ textFieldTemp: UITextField) {
		
		// print("ValueChanged")
		
		
		
	}
	
	func pickerTextFieldEditingDidEnd(_ textFieldTemp: UITextField) {
		if let index = pickerView.selectedRow(inComponent: 0) as Int? {
			
			let country: India.State = india.states[index]
			
			self.text = "\(String(describing: country.stateName!))"
			
			closureEditingDidEnd?(country)
		}
	}
	
}



extension UIStatePickerTextField  : UIPickerViewDelegate , UIPickerViewDataSource {
	
	func numberOfComponents(in _: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
		return india.states.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let country: India.State = india.states[row]
		
		return " \(String(describing: country.stateName!))"
		
	}
	
	func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
		
		let country: India.State = india.states[row]
		
		self.text = "\(String(describing: country.stateName!))"
		
		closureDidSelectState?(country)
		
	}
}

