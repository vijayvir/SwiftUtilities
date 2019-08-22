//
//  LeoCrash.swift
//  UGW
//
//  Created by tecH on 29/07/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
class LeoCrash {

    class func stack(){
        NSSetUncaughtExceptionHandler { exception in
            print("Error Handling: ", exception)
            print("Error Handling callStackSymbols: ", exception.callStackSymbols)
        }
    }
    class func kill(){
        
    //    fatalError("Failed to load a MyCustomCell from the table.")
       // Darwin.kill(getpid(), SIGKILL);
    }
}
