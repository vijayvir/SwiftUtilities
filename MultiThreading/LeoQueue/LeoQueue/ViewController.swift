//
//  ViewController.swift
//  LeoQueue
//
//  Created by Vijayvir Singh on 01/10/20.
//

import UIKit
/*
 Resources:
  https://www.avanderlee.com/swift/concurrent-serial-dispatchqueue/
  https://www.appcoda.com/ios-concurrency/
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // dispatchQueue()
         print(LeoQueue.isMainThread)
        LeoOperationQueue.standard.queue.addOperation {
            print("A1: First Operation run in background thread. Is this is main block?", LeoQueue.isMainThread)
            // OutPut:
            //A1: First Operation. Is this is main block? false
            LeoOperationQueue.mainQueue {
                print("A1.1 Code of block run in main queue after run in corcurrent thread. Is this main queue?", LeoQueue.isMainThread)
            }
        }
        
        LeoOperationQueue.standard.queue.addOperation {
            print("A2: Second Operation run in background thread. Is this is main block?", LeoQueue.isMainThread)
            /* Output
             A1: First Operation run in background thread. Is this is main block? false
             A2: Second Operation run in background thread. Is this is main block? false
             A1.1 Code of block run in main queue after run in corcurrent thread. Is this main queue? true
             A2.1 Code of block run in main queue after run in corcurrent thread. Is this main queue? true

             */
            LeoOperationQueue.mainQueue {
                print("A2.1 Code of block run in main queue after run in corcurrent thread. Is this main queue?", LeoQueue.isMainThread)
            }
        }
        /*******************assing Block opertions to the queue with competions  block************************/
        
        let queueTwo = LeoOperationQueue().queue
        
        // First Block
        let bo1 = BlockOperation {
            print("B1.1 block operations first code is ran, Is this main thread", LeoQueue.isMainThread)
        }
        bo1.completionBlock = {
            print("B1.2 comletions block is ran. Is this main thread", LeoQueue.isMainThread)
        }
        
        queueTwo.addOperation(bo1)
        /*
         Output :
         B1.1 block operations first code is ran, Is this main thread false
         B1.2 comletions block is ran. Is this main thread false
         */
        
        // Second Block
        let bo2 = BlockOperation {
            queueTwo.cancelAllOperations()
            print("B2.1 block operations second code is ran, Is this main thread", LeoQueue.isMainThread)
   
        }
        bo2.completionBlock = {
            print("B2.2 comletions block is ran. Is this main thread", LeoQueue.isMainThread)
           
            LeoOperationQueue.mainQueue {
                print("B2.3 Code of block run in main queue after run in corcurrent queue. Is this main queue?", LeoQueue.isMainThread)
            }
        }
        
        queueTwo.addOperation(bo2)
        /*
         Output:
         B1.1 block operations first code is ran, Is this main thread false
         B2.1 block operations second code is ran, Is this main thread false
         B1.2 comletions block is ran. Is this main thread false
         B2.2 comletions block is ran. Is this main thread false
         B2.3 Code of block run in main queue after run in corcurrent queue. Is this main queue? true
         */
        
        
        // Thrid Block
        let bo3 = BlockOperation {
            print("B3.1 block operations third code is ran, Is this main thread", LeoQueue.isMainThread)
          
        }
        bo3.completionBlock = {
            print("B3.2 comletions block is ran. Is this main thread", LeoQueue.isMainThread)
            
        }
        queueTwo.addOperation(bo3)
        
//        bo2.addDependency(bo1)
//        bo2.addDependency(bo3)
        
        let o1 = LeoOperations(value: 24)
        o1.completionBlock = {
            print("o1:Custom competion block is called", o1.value)
        }
        queueTwo.addOperation(o1)
        
        let o2 = LeoOperations(value: 5)
        o2.completionBlock = {
            print("o2:Custom competion block is called")
        }
        queueTwo.addOperation(o2)
        /*
         
         */
        
        
        
        //          queueTwo.cancelAllOperations() only works in dependency block.
        
    }
    
    
    func operationQueue(){
        
    }
    
    
    func dispatchQueue() {
        
        /*
         In dispatch queue you will learn following points
         1 Check if the current thread is main thread.
         2.Put the block of code in background thread.
         3.Put back background thread to the main thread.
         4.Make the private thread from the calle thread and gives control to main thread or calli thread.
    
         */
        
        print(LeoQueue.isMainThread)
        LeoQueue.mainThread {
            print("1.1.This Code Ran in Main Thread with async. Is this Main Thread?", LeoQueue.isMainThread)
            // OutPut: 1.1.This Code Ran in Main Thread with async. Is this Main Thread? tru
        }
/*
        LeoQueue.mainThread(isSync: true) {
            print("1.1.This Code Ran in Main Thread with async. Is this Main Thread?",LeoQueue.isMainThread)
            // This code will give run time error as it block  thread
        }
 */
        LeoQueue.globalQueue(isSync: false ) {
            print("2.1.This Code Ran in globalQueue with Async. Is this Main Thread?", LeoQueue.isMainThread)
            LeoQueue.mainThread(isSync: true ) {
                print("2.1.1: merge the non main thread queue to main Queue with async, Is this main thread", LeoQueue.isMainThread)
                //Output: 2.1.1: merge the non main thread queue to main Queue with async, Is this main thread true
            }
            //Output: 2.1.This Code Ran in globalQueue with Async. Is this Main Thread? false
        }
        LeoQueue.globalQueue(isSync: true  ) {
            
            print("2.2.This Code Ran in globalQueue with sync. Is this Main Thread?", LeoQueue.isMainThread)
           // OutPut: 2.2.This Code Ran in globalQueue with sync. Is this Main Thread? true
        }
      
        LeoQueue.serialDispatchQueue {
            print("3.1.1 First task in serial dispach queue. Is this main tread?", LeoQueue.isMainThread)
            print("3.1.1:Task 1 started")
               // Do some work..
               print("3.1.1:Task 1 finished")
        }
        LeoQueue.serialDispatchQueue {
            print("3.1.2 Second task in serial dispach queue. Is this main tread?", LeoQueue.isMainThread)
            print("3.1.2 Task 2 started")
               // Do some work..
               print("3.1.2 Task 2 finished")
        }
        
        
        /********************************************/
        /*
         This 4.1 example is dispatch concurrent queue with Async. It result says that task two can run before task one. They are not in queue
         Output:
         4.1.2 Second task in concurrent dispach queue with asyc. Is this main tread? false
         4.1.2 Task 2 started
         4.1.2 Task 2 finished
         4.1.1 First task in concurrent dispach queue with asyc. Is this main tread? false
         4.1.1 Task 2 started
         4.1.1 Task 2 finished
         */
        LeoQueue.concurrentDispatchQueue(isSync: false) {
            print("4.1.1 First task in concurrent dispach queue with async. Is this main tread?", LeoQueue.isMainThread)
            print("4.1.1 Task 2 started")
               // Do some work..
               print("4.1.1 Task 2 finished")
        }
        
        LeoQueue.concurrentDispatchQueue(isSync: false) {
            print("4.1.2 Second task in concurrent dispach queue with async. Is this main tread?", LeoQueue.isMainThread)
            print("4.1.2 Task 2 started")
               // Do some work..
               print("4.1.2 Task 2 finished")
        }
        
        /********************************************/
        
        /* This 4.2 example is concurrent Dispatch Queue in sync. From output it comes to know that first, Ist is performed and then second task is performed.
         
         OutPut:
         4.2.1 First task in concurrent dispach queue with sync. Is this main tread? true
         4.2.1 Task 2 started
         4.2.1 Task 2 finished
         
         4.2.2 Second task in concurrent dispach queue with sync. Is this main tread? true
         4.2.2 Task 2 started
         4.2.2 Task 2 finished
         */
        LeoQueue.concurrentDispatchQueue(isSync: true) {
            print("4.2.1 First task in concurrent dispach queue with sync. Is this main tread?", LeoQueue.isMainThread)
            print("4.2.1 Task 2 started")
               // Do some work..
               print("4.2.1 Task 2 finished")
        }
        
        LeoQueue.concurrentDispatchQueue(isSync: true) {
            print("4.2.2 Second task in concurrent dispach queue with sync. Is this main tread?", LeoQueue.isMainThread)
            print("4.2.2 Task 2 started")
               // Do some work..
               print("4.2.2 Task 2 finished")
        }
        
        
        
        /**************************************/
        
        LeoQueue.mainThread {
            
            let messenger = Messenger()
            // Executed on Thread #1
            messenger.postMessage("Hello SwiftLee!")
            // Executed on Thread #2
            LeoQueue.globalQueue {
                print("M1: ",messenger.lastMessage ?? "" , LeoQueue.isMainThread) // Prints: Hello SwiftLee!
            }// Will throw back on main thread
            
            print("M2: ",messenger.lastMessage ?? "" , LeoQueue.isMainThread) // Prints: Hello
            
            /*Output:
            M2:  Hello SwiftLee! true
            M1:  Hello SwiftLee! false
            */
        }
        
    }
}

