import Foundation
import UIKit
struct LeoClock {
	struct DayLight {
		var value : Bool
		var name : String
	}
	var  dayLights : [DayLight] = []
	var selectRow : Int {
		return 0
	}
	init() {
        let am = DayLight(value: true, name: "AM")
		    let pm = DayLight(value: true, name: "PM")
        dayLights.append(am)
		   dayLights.append(pm)
		}
	}
class LeoClockTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
	var pickerView: UIPickerView = UIPickerView()
	var isAm : Bool  = true {
		didSet {
			if isAm  {
				pickerView.selectRow(leoClock.selectRow, inComponent: 0, animated: true)
				if let index = pickerView.selectedRow(inComponent: leoClock.selectRow) as Int? {
					let country: LeoClock.DayLight = leoClock.dayLights[index]
					self.text = "\(country.name)"
					closureDidSelectValue?(country)
					self.currentValue = country
				}
			} else {
				pickerView.selectRow(1, inComponent: 0, animated: true)
				if let index = pickerView.selectedRow(inComponent: 0) as Int? {
					let country: LeoClock.DayLight = leoClock.dayLights[index]
					self.text = "\(country.name)"
					closureDidSelectValue?(country)
					self.currentValue = country
				}
			}
		}
	}
	var leoClock : LeoClock = LeoClock()
	public  var closureDidSelectValue: ((_ value: LeoClock.DayLight ) -> Void)?
	var currentValue : LeoClock.DayLight?
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addInputAccessoryView()
		self.textAlignment = .center
		self.inputView = pickerView
		pickerView.dataSource = self
		pickerView.delegate = self
		isAm = true
		pickerView.selectRow(leoClock.selectRow, inComponent: 0, animated: true)
		if let index = pickerView.selectedRow(inComponent: leoClock.selectRow) as Int? {
			let country: LeoClock.DayLight = leoClock.dayLights[index]
			self.currentValue = country
			self.text = "\(country.name)"
			
		}
	}
	func addInputAccessoryView() {
		let toolbar = UIToolbar()
		toolbar.sizeToFit()
		let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))
		let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		var arraybutton: [UIBarButtonItem] = []
		//   arraybutton.append(donebutton)
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
			let country: LeoClock.DayLight = leoClock.dayLights[index]
			self.text = "\(country.name)"
			closureDidSelectValue?(country)
			self.currentValue = country
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
		return leoClock.dayLights.count
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let country: LeoClock.DayLight = leoClock.dayLights[row]
		return " \(country.name)"
	}
	func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
		let country: LeoClock.DayLight = leoClock.dayLights[row]
		self.text = " \(country.name)"
		closureDidSelectValue?(country)
		self.currentValue = country
	}
}
