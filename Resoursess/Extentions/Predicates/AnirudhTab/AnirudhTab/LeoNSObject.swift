//
//  LeoNSObject.swift
//  AnirudhTab
//
//  Created by Vijayvir Singh on 09/10/20.
//
import UIKit
import Foundation
private var LeoAddObserver: UInt8 = 0
private var LeoAddObseverClosure: UInt8 = 0
extension NSObject {
    var closureNSObject: ((NSNotification)->())? {
                get {
                    return objc_getAssociatedObject(self, &LeoAddObseverClosure) as?  ((NSNotification)->())
                }
                set {
                    objc_setAssociatedObject(self, &LeoAddObseverClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
    
    func leoAddObsever(_ string: String , callback : @escaping ((NSNotification)->()) ) {
        closureNSObject = callback
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(string), object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.leoSelector1),
            name: Notification.Name(string),
            object: nil)
    }
    @objc private func leoSelector1(notification: NSNotification){
        
        closureNSObject?(notification)
    }
    
    
}

private var LeoAddObserver2: UInt8 = 0
private var LeoAddObseverClosure2: UInt8 = 0
extension NSObject {
    var closureNSObject2: ((NSNotification)->())? {
                get {
                    return objc_getAssociatedObject(self, &LeoAddObseverClosure2) as?  ((NSNotification)->())
                }
                set {
                    objc_setAssociatedObject(self, &LeoAddObseverClosure2, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
    
    func leoAddObsever2(_ string: String , callback : @escaping ((NSNotification)->()) ) {
        closureNSObject2 = callback
        NotificationCenter.default.removeObserver(self, name: Notification.Name(string), object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.leoSelector2),
            name: Notification.Name(string),
            object: nil)
    }
    @objc private func leoSelector2(notification: NSNotification){
        
        closureNSObject2?(notification)
    }
    
    
}
private var LeoAddObserver3: UInt8 = 0
private var LeoAddObseverClosure3: UInt8 = 0
extension NSObject {
    var closureNSObject3: ((NSNotification)->())? {
                get {
                    return objc_getAssociatedObject(self, &LeoAddObseverClosure3) as?  ((NSNotification)->())
                }
                set {
                    objc_setAssociatedObject(self, &LeoAddObseverClosure3, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
    
    func leoAddObsever3(_ string: String , callback : @escaping ((NSNotification)->()) ) {
        closureNSObject3 = callback
        NotificationCenter.default.removeObserver(self, name: Notification.Name(string), object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.leoSelector3),
            name: Notification.Name(string),
            object: nil)
    }
    @objc private func leoSelector3(notification: NSNotification){
        
        closureNSObject3?(notification)
    }
    
    
}
