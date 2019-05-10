//
//  LeoCoreData.swift
//  UGW
//
//  Created by tecH on 30/04/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    fileprivate static var leoContextClosureKey: UInt8 = 0
    
    
    var closureOnEvent : ((Notification)-> Void)?{
        set (newValue) {
            objc_setAssociatedObject(self, &NSManagedObjectContext.leoContextClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get{
            return objc_getAssociatedObject(self, &NSManagedObjectContext.leoContextClosureKey) as?  ((Notification)-> Void)
        }
    }
    func leoObserver(   callback : ((Notification) -> Void )? = nil ) {
        if callback != nil  {
            
            closureOnEvent = callback
            NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
            // NotificationCenter.default.addObserver(self, selector: #selector(contextWillSave(_:)), name: Notification.Name.NSManagedObjectContextWillSave, object: nil)
            //   NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: nil)
        }
        
    }
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        // print(notification)
        closureOnEvent?(notification)
    }
    @objc func contextWillSave(_ notification: Notification) {
        closureOnEvent?(notification)
    }
    @objc func contextDidSave(_ notification: Notification) {
        closureOnEvent?(notification)
    }
    
    
}
