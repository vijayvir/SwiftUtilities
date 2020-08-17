//
//  LeoCrash.swift
//  LeoCrashMachnism
//
//  Created by Vijayvir Singh on 01/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import Foundation
import Foundation
class LeoCrash {

    class func stack(){
        NSSetUncaughtExceptionHandler { exception in
            print("Error Handling: ", exception)
            print("Error Handling callStackSymbols: ", exception.callStackSymbols)
        }
    }
    class func kill(){
        
        //fatalError("Failed to load a MyCustomCell from the table.")
        
        //let some : [String] = []
      //  print(some.first!)
        
    }
}
