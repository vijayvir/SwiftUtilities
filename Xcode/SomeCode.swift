//
//  SomeCode.swift
//  iSpy
//
//  Created by tecH on 10/05/19.
//  Copyright © 2019 tecH. All rights reserved.
//
// https://stackoverflow.com/questions/44670876/is-there-a-way-to-get-list-of-variables-and-function-of-a-class
import Foundation
func printMethodNamesForClass(cls: AnyClass) {
    var methodCount: UInt32 = 0
    let methodList = class_copyMethodList(cls, &methodCount)
    if methodList != nil && methodCount > 0 {
        
        enumerateCArray(array: methodList, count: methodCount) { (some, type) in
            print(some , type)
            print(method_getName(type))
            print(method_copyArgumentType(type, 0))
             print(method_getNumberOfArguments(type))
             print(method_getImplementation(type).debugDescription)
            
            print(method_copyReturnType(type))
            
        }
     
        
//        enumerateCArray(array: methodList ?? <#default value#>, count: methodCount) { i, m in
//            let name = methodName(m) ?? "unknown"
//            println("#\(i): \(name)")
//        }
        
        free(methodList)
    }
}
func enumerateCArray<T>(array: UnsafePointer<T>?, count: UInt32, f: (UInt32, T) -> ()) {
   
    if array != nil {
        var ptr = array!
        
  
        for i in 0..<count {
            
            f(i, ptr.pointee)
            ptr = ptr.successor()
        }
    }
  
}

/*
 
 func printMethodNamesForClass(cls: AnyClass) {
 var methodCount: UInt32 = 0
 let methodList = class_copyMethodList(cls, &methodCount)
 if methodList != nil && methodCount > 0 {
 enumerateCArray(methodList, methodCount) { i, m in
 let name = methodName(m) ?? "unknown"
 println("#\(i): \(name)")
 }
 
 free(methodList)
 }
 }
 func enumerateCArray<T>(array: UnsafePointer<T>, count: UInt32, f: (UInt32, T) -> ()) {
 var ptr = array
 for i in 0..<count {
 f(i, ptr.memory)
 ptr = ptr.successor()
 }
 }
 func methodName(m: Method) -> String? {
 let sel = method_getName(m)
 let nameCString = sel_getName(sel)
 return String.fromCString(nameCString)
 }
 func printMethodNamesForClassNamed(classname: String) {
 // NSClassFromString() is declared to return AnyClass!, but should be AnyClass?
 let maybeClass: AnyClass? = NSClassFromString(classname)
 if let cls: AnyClass = maybeClass {
 printMethodNamesForClass(cls)
 }
 else {
 println("\(classname): no such class")
 }
 }
 */
