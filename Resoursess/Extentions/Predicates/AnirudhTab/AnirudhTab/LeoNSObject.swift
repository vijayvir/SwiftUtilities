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
