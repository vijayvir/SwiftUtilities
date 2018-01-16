//
//  EstimatorTimerObject.swift
//  ProjectTimer
//
//  Created by vijay vir on 1/15/18.
//  Copyright © 2018 vijay vir. All rights reserved.
//
import UIKit
extension Date {
	var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
	var hour12:  String      { return Formatter.hour12.string(from: self) }
	var minute0x: String     { return Formatter.minute0x.string(from: self) }
	var amPM: String         { return Formatter.amPM.string(from: self) }
}
extension Formatter {
	static let monthMedium: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "LLL"
		return formatter
	}()
	static let hour12: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "h"
		return formatter
	}()
	static let minute0x: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "mm"
		return formatter
	}()
	static let amPM: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "a"
		return formatter
	}()
}

class LeoPickerColumn: NSObject {
	@IBInspectable var max : Int  = 20
	@IBInspectable var min : Int = 0
	@IBInspectable var isHour : Bool = false
	@IBOutlet weak var lblValue: UILabel?
	@IBOutlet weak var btnPlus: UIButton?
	@IBOutlet weak var btnMinus: UIButton?
	var closureDidValueSet : ((Int) -> Void )?
	@IBInspectable var value  : Int = 0 {
		didSet {
			closureDidValueSet?(value)
			if value <= min {
				btnMinus?.isEnabled = false
			} else {
				btnMinus?.isEnabled = true
			}
			if value >= max {
				btnPlus?.isEnabled = false
			} else {
				btnPlus?.isEnabled = true
			}
			lblValue?.text = "\(value)"
			if isHour {
           		lblValue?.text = "\(value % 12 )"
			}
		}
	}
	func configure(){
		lblValue?.text = "\(value)"
		if isHour {
			lblValue?.text = "\(value % 12 )"
		}
	}
	func configure(withValue : Int ) {

		if  withValue > max  {
			value = withValue   - (max + 1)
		}
		else {
			value = withValue
		}
	}
	@IBAction func actionPlus(_ sender: UIButton) {
		value = value + 1
	}
	@IBAction func actionMinus(_ sender: UIButton) {
		value = value - 1
	}
}
import UIKit
class NxSpotEstimatorTimerObject: NSObject {

	@IBOutlet weak var txtClock: LeoClockTextField!
	@IBOutlet weak var leoPickerColumnHours: LeoPickerColumn!
	@IBOutlet weak var leoPickerColumnHoursDepended: LeoPickerColumn!
	@IBOutlet weak var leoPickerColumnMins: LeoPickerColumn!
	@IBOutlet weak var leoPickerColumnMinsDepended: LeoPickerColumn!
	var closureDidEstimatorTimeSet : (( Int , Int , LeoClock.DayLight ) -> Void )?
	func configure() {
		leoPickerColumnHours.closureDidValueSet = { value in
			let date = Date()
			let calendar = Calendar.current
			let hour = calendar.component(.hour, from: date)
			self.leoPickerColumnHoursDepended.configure(withValue: hour + value)
		}
		leoPickerColumnHours.configure(withValue: 0)

		leoPickerColumnHoursDepended.configure(withValue: 0)
	  let date = Date()
		if date.amPM == "PM" {
			self.txtClock.isAm = false
		} else {
			self.txtClock.isAm = true
		}

		leoPickerColumnHoursDepended.closureDidValueSet = {
			value in
			self.closureDidEstimatorTimeSet?(value ,self.leoPickerColumnMinsDepended.value , self.txtClock.currentValue!)
		}

		//***************************************
		self.txtClock.closureDidSelectValue = { dayLight in
						self.closureDidEstimatorTimeSet?(	self.leoPickerColumnHoursDepended.value , self.leoPickerColumnMinsDepended.value , dayLight)
		}
		leoPickerColumnMins.closureDidValueSet = { value in

			let date = Date()
			let calendar = Calendar.current

			let minutes = calendar.component(.minute, from: date)


			self.leoPickerColumnMinsDepended.configure(withValue: minutes + value)
		}
		leoPickerColumnMins.configure(withValue: 0)
		leoPickerColumnMinsDepended.configure(withValue: 0)
		leoPickerColumnMinsDepended.closureDidValueSet = {
			value in
			self.closureDidEstimatorTimeSet?(	self.leoPickerColumnHoursDepended.value , self.leoPickerColumnMinsDepended.value , self.txtClock.currentValue!)
		}



	}

}

/*
@IBOutlet var nxSpotEstimatorTimerObject: NxSpotEstimatorTimerObject!
override func viewDidLoad() {
super.viewDidLoad()
nxSpotEstimatorTimerObject.configure()
nxSpotEstimatorTimerObject.closureDidEstimatorTimeSet  = {
hrs , mins in
print( "🚘🚘🚘🚘🚘",hrs , mins)
}
}

*/



