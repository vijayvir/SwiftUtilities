//
//  TextField.swift
//  Apex
//
//  Created by Nitish Sharma on 10/10/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//
import Foundation
import UIKit
import UserNotifications
// MARK : Key features
/*
 placeholderColor
 
 */


extension UITextField {
    func placeholderColor( _ text : String? = "" ,   color :UIColor? = .gray  ) {
        self.placeholder = text
        self.attributedPlaceholder = NSAttributedString(string: text!,
                                                        attributes: [NSAttributedString.Key.foregroundColor:color!])
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UITextField {
    func isValidEmailAddress() -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self.text.leoSafe() as NSString
            let results = regex.matches(in: self.text.leoSafe(), range: NSRange(location: 0, length: nsString.length))
            if results.count == 0{
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    func lenght() -> Bool {
        if self.text.leoSafe().count <= 0 {
            return false
        }
        return true
    }
    
}
fileprivate var leoTextfieldClosureKey: UInt8 = 0

fileprivate var leoTextfieldShouldChangeCharactersInClosureKey: UInt8 = 0

extension UITextField  : UITextFieldDelegate{
    
    private  var closureShouldChangeCharactersIn :((String)-> Bool)? {
        set (newValue) {
            objc_setAssociatedObject(self, &leoTextfieldShouldChangeCharactersInClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return objc_getAssociatedObject(self, &leoTextfieldShouldChangeCharactersInClosureKey) as?  ((String) -> Bool )
        }
    }
    
    func leoShouldChangeCharactersIn( callback : @escaping ((String) -> Bool )) {
        self.delegate = self
        closureShouldChangeCharactersIn = callback
        
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return  closureShouldChangeCharactersIn?(string) ?? false
    }
    
}


extension UITextField {
    
    // var closureObserver :
    
    
    
    @objc func yourfunction(notfication: NSNotification) {
        print("xxx")
    }
    
    func leoObserver( on : UIControl.Event = .editingChanged  ,  callback : (() -> Void )? = nil ) {
        if callback != nil  {
            
            NotificationCenter.default.addObserver(self, selector: #selector(yourfunction(notfication:)), name: Notification.Name("postNotifi"), object: on)
        }
        
    }
    
    
    
    
}
extension UITextField {
    
    private  var closureOnEvent : (()-> Void)?{
        set (newValue) {
            objc_setAssociatedObject(self, &leoTextfieldClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return objc_getAssociatedObject(self, &leoTextfieldClosureKey) as?  (()-> Void)
        }
    }
    
    
    func leoListen( on : UIControl.Event = .editingChanged  ,  callback : (() -> Void )? = nil ) {
        
        self.addTarget(self, action: #selector(textFieldEditingDidChange(_:event:)), for:on)
        closureOnEvent = callback
    }
    @objc func textFieldEditingDidChange(_ sender: Any , event :  UIControl.Event){
        
        closureOnEvent?()
        
        
    }
}
