//
//  FATabButton.swift
//  AnirudhTab
//
//  Created by Vijayvir Singh on 09/10/20.
//

import UIKit
class FATabButton: UIButton {
    @IBInspectable var identifier: String = ""
    @IBInspectable var selectedTab: String = ""
    @IBOutlet  var continer : UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
private var LeoViewTapGesture: UInt8 = 0
private var LeoViewTapGestureClosure: UInt8 = 0

extension FATabButton {
    var elementButton:Any {
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
    
    func leoTapButton(element : Any , callback : @escaping ((Any)->())){
    closure1 = callback
    self.elementButton = element
    self.isUserInteractionEnabled = true
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
     self.isUserInteractionEnabled = true
     self.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer) {
         closure1?(elementButton)
       
    }
}
