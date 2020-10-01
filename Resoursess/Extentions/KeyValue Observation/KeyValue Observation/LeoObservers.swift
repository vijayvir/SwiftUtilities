//
//  LeoObservers.swift
//  KeyValue Observation
//
//  Created by Vijayvir Singh on 01/10/20.
//
import UIKit
import Foundation
// REsource : https://nalexn.github.io/kvo-guide-for-key-value-observing/
extension NSObjectProtocol where Self: NSObject {
    func observe<Value>(_ keyPath: KeyPath<Self, Value>, onChange: @escaping (Value) -> Void) -> NSKeyValueObservation {
        observe(keyPath, options: [.initial, .new]) { _, change in
            guard let newValue = change.newValue else { return }
            onChange(newValue)
        }
    }

    func leoBind<Value, Target>(_ sourceKeyPath: KeyPath<Self, Value>, to target: Target, at targetKeyPath: ReferenceWritableKeyPath<Target, Value>) -> NSKeyValueObservation {
        observe(sourceKeyPath) { target[keyPath: targetKeyPath] = $0 }
    }
}
