//
//  LeoThreads.swift
//  SharePhotoApp
//
//  Created by tecH on 21/05/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation

struct LeoQueue {
    
    static var isMainThread : Bool {
        if Thread.isMainThread {
            return true
        }
        
        return false
    }
    
    
    static func mainThread(_ callback : @escaping (() -> ())) {
        DispatchQueue.main.async {
            callback()
        }
    }
    static func mainSyncThread(_ callback : @escaping (() -> ())) {
        DispatchQueue.main.sync {
            callback()
        }
    }
    static func queueGlobal( qos: DispatchQoS.QoSClass = .default ,
                             callback : @escaping (() -> ())) {
        
        DispatchQueue.global(qos: qos ).async{
            callback()
        }
        
        
    }
    static func concurrentQueue( isSync : Bool = false ,
                                 callback : @escaping (() -> ())) {
        
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
        if isSync {
            
            concurrentQueue.sync {
                callback()
            }
            
        }else {
            concurrentQueue.async {
                callback()
            }
        }
        
        
        
    }
    
    
    
    
    
    
    
    
}


