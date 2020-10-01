//
//  Messanger.swift
//  LeoQueue
//
//  Created by Vijayvir Singh on 01/10/20.
//

import Foundation
final class Messenger {
/*
     The following code demonstrates a messenger class that can be accessed from multiple threads at the same time. Adding new messages to the array is done using the barrier flag which blocks new reads until the write is finished.
     */
    private var messages: [String] = []
    private lazy var  queue : DispatchQueue = {
        return DispatchQueue(label: "messages.queue.concurrent", attributes: .concurrent)}()
    private func performBlockAndWait<T>(_ block: () -> T) -> T {
        return queue.sync {
            return block()
        }
    }
    var lastMessage: String? {
//        return queue.sync {
//            messages.last
//        }
        return performBlockAndWait { () ->  String? in
            messages.last
        }
        //  return queue.sync {
       // messages.last
  //  }
    }
    func postMessage(_ newMessage: String) {
        queue.sync(flags: .barrier) {
            messages.append(newMessage)
        }
    }
}
