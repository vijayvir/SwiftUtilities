//
//  AppDelegate.swift
//  UIPunjabDistrictTextfield
//
//  Created by vijay vir on 8/18/17.
//  Copyright © 2017 vijay vir. All rights reserved.

import UIKit

struct Punjab {

    struct District {

        var districtName: Any?

        var division: Any?

        var region : Any?

        var latitude: Any?

        var longitude: Any?

    }
    var districts: [District] = []

    init() {

        let object = leoReadDataFromCSV(bunldePath: "PunjabDistrict", extention: "csv")

        if var states = object as? [Any] {

            states.remove(at: 0)

            for tempState in states {

                if let state = tempState as? [Any] {

                    if state.count == 5 {

                        let statee: Punjab.District = Punjab.District(districtName: state[0] ,
                                                              division: state[1] ,
                                                              region: state[2] ,
                                                              latitude: state[3] ,
                                                              longitude: state[4])

                        self.districts.append(statee)
                    }

                }
            }
        }

    }

}

class PunjabDistrictPickerTextField: UITextField {

	 let punjab = Punjab()

	 let  pickerView  = UIPickerView()

	 public  var closureDidSelectDistrict: ((_ district: Punjab.District ) -> Void)?

    var closureEditingDidBegin : ((_ district: Punjab.District ) -> Void)?

	 var closureValueChanged : ((_ district: Punjab.District ) -> Void)?

	 var closureEditingDidEnd : ((_ district: Punjab.District ) -> Void)?

    // clc : class life cycle methods

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.addTarget(self, action: #selector(PunjabDistrictPickerTextField.pickerTextFieldEditingDidBegin(_:)), for: UIControl.Event.editingDidBegin)

        self.addTarget(self, action: #selector(PunjabDistrictPickerTextField.pickerTextFieldEditingDidEnd(_:)), for: UIControl.Event.editingDidEnd)

        addInputAccessoryView()

        self.inputView = pickerView

        pickerView.dataSource = self

        pickerView.delegate = self

        pickerView.selectRow(0, inComponent: 0, animated: true)

        if let index = pickerView.selectedRow(inComponent: 0) as Int? {

            let districs: Punjab.District = punjab.districts[index]

              self.text = "\(String(describing:  districs.districtName ?? "" ))"

        }
    }

    func addInputAccessoryView() {

        let toolbar = UIToolbar()

        toolbar.sizeToFit()

        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        var arraybutton: [UIBarButtonItem] = []

        arraybutton.append(donebutton)

        arraybutton.append(space)

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

            let districs: Punjab.District = punjab.districts[index]

            self.text = "\(String(describing: districs.districtName ?? ""  ))"

            closureDidSelectDistrict?(districs)

        }
        _ = resignFirstResponder()
    }

}

extension PunjabDistrictPickerTextField {

    @objc func pickerTextFieldEditingDidBegin(_ textFieldTemp: UITextField) {

		if let index = pickerView.selectedRow(inComponent: 0) as Int? {

			let distict: Punjab.District = punjab.districts[index]

			self.text = "\(String(describing: distict.districtName ?? ""))"

			closureEditingDidBegin?(distict)
		}

	}

	func pickerTextFieldValueChanged(_ textFieldTemp: UITextField) {

		// print("ValueChanged")

	}

    @objc func pickerTextFieldEditingDidEnd(_ textFieldTemp: UITextField) {

		if let index = pickerView.selectedRow(inComponent: 0) as Int? {

			let distict: Punjab.District = punjab.districts[index]

			self.text = "\(String(describing: distict.districtName ?? ""))"

			closureEditingDidEnd?(distict)
		}

	}
}

// MARK: PickerViewDelegate

extension PunjabDistrictPickerTextField : UIPickerViewDelegate, UIPickerViewDataSource {

    public func numberOfComponents(in _: UIPickerView) -> Int {

        return 1

    }

    public func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {

        return punjab.districts.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        let dist: Punjab.District = punjab.districts[row]

        return " \(String(describing: dist.districtName ?? "" ))"
    }
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {

        let districs: Punjab.District = punjab.districts[row]

        self.text = "\(String(describing: districs.districtName ?? ""  ))"

        closureDidSelectDistrict?(districs)

    }
}
