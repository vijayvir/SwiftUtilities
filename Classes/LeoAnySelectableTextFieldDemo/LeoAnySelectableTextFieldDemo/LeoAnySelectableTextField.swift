//
//  LeoAnySelectableTextField.swift
//  LeoAnySelectableTextFieldDemo
//
//  Created by tecH on 12/07/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//
import UIKit
import Foundation
@objc protocol  LeoSelectable  : class {
    
    var leoIsSelected  : Bool {get set }
    
    var leoTitle : String { get  }
    
    @objc optional var leoDetailText : String? { get  }
    
    @objc optional var leoImage : UIImage? { get  }
}



class LeoAnySelectableTextField: UITextField  {
    
    @IBInspectable var tintColorLeo : UIColor = .blue {
        didSet{
            
            closureUpdateUI?()
        }
    }
    
    private var closureUpdateUI : (() -> Void)?
    
    
    @IBInspectable var isSingleSelection : Bool = false
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = UIColor.init(displayP3Red: 246, green: 246, blue: 246, alpha: 1)
        tableView.register(LeoAnySelectableTableViewCell.self, forCellReuseIdentifier: "LeoAnySelectableTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    private var elements: [LeoSelectable] = []
    
    var selectedElements : [LeoSelectable] {
        
        return elements.filter({ (element) -> Bool in
            if element.leoIsSelected {
                return  true
            }
            return false
        })
        
    }
    private  var closureDidSelectElements: ((_ selectedElements: [LeoSelectable]) -> Void)?
    
    
    func withClosureDidSelectElements(_ closure :  @escaping  (_ selectedElements: [LeoSelectable]) -> Void) -> LeoAnySelectableTextField {
        
        closureDidSelectElements = closure
        return self
        
    }
    
    
    func withStop(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        
        addInputAccessoryView()
        
        self.inputView = tableView
        if elements.count <= 0 {
            self.isEnabled = false
        }else {
            self.isEnabled = true
        }
        
        
    }
    
    
    func configure(withElements : [LeoSelectable] , _ closure :  ((_ selectedElements: [LeoSelectable]) -> Void)? = nil   ) -> LeoAnySelectableTextField {
        self.elements = withElements
        self.tableView.reloadData()
        
        if elements.count <= 0 {
            self.isEnabled = false
            
        }else {
            self.isEnabled = true
        }
        closure?(withElements)
        
        
        return self
    }
    
    private func addInputAccessoryView()  {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //  toolbar.barTintColor = UIColor.darkText
        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuDoneButtonTapped(sender:)))
        
        let cancelbutton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(menuCancelButtonTapped(sender:)))
        cancelbutton.tintColor = tintColorLeo
        
        
        
        
        let label = UILabel()
        label.text = "Select atleast one."
        label.font = UIFont(name: "SourceSansPro-Regular", size: 13)
        label.textAlignment = .center
        
        label.backgroundColor =  .clear
        
        closureUpdateUI = {
            cancelbutton.tintColor = self.tintColorLeo
            donebutton.tintColor = self.tintColorLeo
            label.textColor =  self.tintColorLeo
            self.tableView.tintColor = self.tintColorLeo
        }
        
        
        let barButton = UIBarButtonItem(customView: label)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var arraybutton: [UIBarButtonItem] = []
        arraybutton.append(cancelbutton)
        arraybutton.append(space)
        arraybutton.append(barButton)
        arraybutton.append(space)
        arraybutton.append(donebutton)
        toolbar.setItems(arraybutton, animated: true)
        self.inputAccessoryView = toolbar
    }
    
    @objc func menuDoneButtonTapped(sender _: UIBarButtonItem) {
        self.closureDidSelectElements?(selectedElements)
        _ = resignFirstResponder()
    }
    
    @objc func menuCancelButtonTapped(sender _: UIBarButtonItem) {
        _ = resignFirstResponder()
        
    }
    
}


extension LeoAnySelectableTextField: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeoAnySelectableTableViewCell", for: indexPath) as! LeoAnySelectableTableViewCell
        let element = elements[indexPath.row]
        cell.configure(element: element)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedElement = elements[indexPath.row]
        
        
        if isSingleSelection {
            
            for  element in elements {
                element.leoIsSelected = false
            }
            
            selectedElement.leoIsSelected =  !selectedElement.leoIsSelected
        }else {
            selectedElement.leoIsSelected =  !selectedElement.leoIsSelected
        }
        
        
        self.closureDidSelectElements?(selectedElements)
        self.tableView.reloadData()
    }
    
    
}

class  LeoAnySelectableTableViewCell         : UITableViewCell {
    
    var element : LeoSelectable?
    
    func configure( element : LeoSelectable) {
        
        self.element = element
        
        self.textLabel?.text = element.leoTitle
        
        if element.leoDetailText  != nil {
            self.detailTextLabel?.text = element.leoDetailText!
        }
        if element.leoImage  != nil {
            
            self.imageView?.contentMode = .scaleAspectFit
            self.imageView?.image =  element.leoImage!
        }
        
        if element.leoIsSelected {
            self.accessoryType = .checkmark
        }else {
            self.accessoryType = .none
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.textLabel?.font = UIFont(name: "SourceSansPro-Semibold", size: 13)
        self.textLabel?.textAlignment = .left
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
