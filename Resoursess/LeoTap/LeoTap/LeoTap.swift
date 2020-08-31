//
//  LeoTap.swift
//  LeoTap
//
//  Created by Vijayvir Singh on 31/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit
private var LeoButtonTapGesture: UInt8 = 0
private var LeoButtonTapGestureClosure: UInt8 = 0
extension UIButton {
    var element:Any {
              get {
                return objc_getAssociatedObject(self, &LeoButtonTapGesture) as Any
              }
              set {
                  objc_setAssociatedObject(self, &LeoButtonTapGesture, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
              }
          }
    
    var closure: ((Any)->())? {
                get {
                    return objc_getAssociatedObject(self, &LeoButtonTapGestureClosure) as?  ((Any)->())
                }
                set {
                    objc_setAssociatedObject(self, &LeoButtonTapGestureClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
    
    func leoTap(element : Any , callback : @escaping ((Any)->())){
    closure = callback
    self.element = element
    self.addTarget(self , action: #selector(actionTap), for: .touchUpInside)
        
    }
    @objc func actionTap() {
         closure?(element)
       
    }
    
}

private var LeoImageViewTapGesture: UInt8 = 0
private var LeoImageViewTapGestureClosure: UInt8 = 0
extension UIImageView {
    var element:Any {
              get {
                return objc_getAssociatedObject(self, &LeoImageViewTapGesture) as Any
              }
              set {
                  objc_setAssociatedObject(self, &LeoImageViewTapGesture, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
              }
          }
    
    var closure: ((Any)->())? {
                get {
                    return objc_getAssociatedObject(self, &LeoImageViewTapGestureClosure) as?  ((Any)->())
                }
                set {
                    objc_setAssociatedObject(self, &LeoImageViewTapGestureClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
    
    func leoTap(element : Any , callback : @escaping ((Any)->())){
    closure = callback
    self.element = element
    self.isUserInteractionEnabled = true
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
     self.isUserInteractionEnabled = true
     self.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
         closure?(element)
       
    }
}
private var LeoLabelTapGesture: UInt8 = 0
private var LeoLabelTapGestureClosure: UInt8 = 0

extension UILabel {
    var element:Any {
              get {
                return objc_getAssociatedObject(self, &LeoLabelTapGesture) as Any
              }
              set {
                  objc_setAssociatedObject(self, &LeoLabelTapGesture, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
              }
          }
    
    var closure: ((Any)->())? {
                get {
                    return objc_getAssociatedObject(self, &LeoLabelTapGestureClosure) as?  ((Any)->())
                }
                set {
                    objc_setAssociatedObject(self, &LeoLabelTapGestureClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
    
    func leoTap(element : Any , callback : @escaping ((Any)->())){
    closure = callback
    self.element = element
    self.isUserInteractionEnabled = true
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
     self.isUserInteractionEnabled = true
     self.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
         closure?(element)
       
    }
}
private var LeoViewTapGesture: UInt8 = 0
private var LeoViewTapGestureClosure: UInt8 = 0

extension UIView {
    var element1:Any {
              get {
                return objc_getAssociatedObject(self, &LeoViewTapGesture) as Any
              }
              set {
                  objc_setAssociatedObject(self, &LeoViewTapGesture, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
              }
          }
    
    var closure1: ((Any)->())? {
                get {
                    return objc_getAssociatedObject(self, &LeoViewTapGestureClosure) as?  ((Any)->())
                }
                set {
                    objc_setAssociatedObject(self, &LeoViewTapGestureClosure, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
    
    func leoTapView(element : Any , callback : @escaping ((Any)->())){
    closure1 = callback
    self.element1 = element
    self.isUserInteractionEnabled = true
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
     self.isUserInteractionEnabled = true
     self.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer) {
         closure1?(element1)
       
    }
}
