//
//  LeoThreads.swift
//  SharePhotoApp
//
//  Created by tecH on 21/05/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation

class LeoQueue {
    
    /// To Check if Queue is main Thread
    static var isMainThread : Bool {
        if Thread.isMainThread {
            return true
        }
        
        return false
    }

    /// Do the things on main thread in Sync and Async
    /// - Parameters:
    ///   - isSync: To make thread sync
    ///   - callback: called the callback block to do the operations
    /// - Returns: nothing.
    static func mainThread( isSync : Bool = false , _ callback : @escaping (() -> ())) {
        if isSync {
            DispatchQueue.main.sync {
                callback()
                // Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
                // Its prefer to put in async, so that it not block the main thread.
            }
        }else {
            DispatchQueue.main.async {
                callback()
            }
        }
       
    }
    //MARK: Global background queue
    static func globalQueue(isSync : Bool = false ,
        qosPriorities: DispatchQoS.QoSClass = .utility ,
                             callback : @escaping (() -> ())) {
        if isSync {
            DispatchQueue.global(qos: qosPriorities ).sync{
                callback()
            }
            
        }else {
            DispatchQueue.global(qos: qosPriorities ).async{
                callback()
            }
            
        }
        
        
    }
    //MARK: Private Queues: Serial or concurrent
    // 
    static func concurrentDispatchQueue( isSync : Bool = false ,
                                         privateLabel: String = "com.queue.Concurrent",
                                 callback : @escaping (() -> ())) {
        // : concurrent If this attribute is not present, the queue schedules tasks serially in first-in, first-out (FIFO) order.
        let concurrentQueue = DispatchQueue(label: privateLabel, attributes: .concurrent)
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
    
    static func serialDispatchQueue( isSync : Bool = false ,
                                     privateLabel: String = "swiftlee.serial.queue",
                                 callback : @escaping (() -> ())) {
        // : concurrent:If this attribute is not present, the queue schedules tasks serially in first-in, first-out (FIFO) order.
        let concurrentQueue = DispatchQueue(label: privateLabel)
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


