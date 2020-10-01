//
//  LeoOperationQueue.swift
//  LeoQueue
//
//  Created by Vijayvir Singh on 01/10/20.
//

import Foundation
class LeoOperationQueue {
    var queue = OperationQueue()
    static var standard = LeoOperationQueue()
    static func mainQueue (callback : @escaping (() -> ())){
        OperationQueue.main.addOperation {
         callback()
        }
    }
}
class LeoContentImportOperation : Operation {
    let itemProvider: NSItemProvider

        init(itemProvider: NSItemProvider) {
            self.itemProvider = itemProvider
            super.init()
        }

        override func main() {
            guard !isCancelled else { return }
            print("Importing content..")
            
            // .. import the content using the item provider

        }
}

class LeoOperations : Operation {
    
    var value : Int = 0
    
     init(value : Int){
        self.value = value
        super.init()
    }
    override func main() {
        guard !isCancelled else {
             return
        }

        print("Main functions is called ",value)
    }
}
