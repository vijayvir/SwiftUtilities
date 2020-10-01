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
 
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dispatchQueue() 
       
    }
    
    func dispatchQueue() {
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

