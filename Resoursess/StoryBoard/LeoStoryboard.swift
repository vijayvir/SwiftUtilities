//
//  LeoStoryboard.swift
//  FuelVCO
//
//  Created by Vijayvir Singh on 31/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
protocol LeoStoryBoarded {
    static func leoStoryboarded()->(String,String)
}
extension LeoStoryBoarded {
static func leoInstantiate() -> Self {
        let storyboard = UIStoryboard(name: leoStoryboarded().0, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: leoStoryboarded().1)
        return vc as! Self
    }
}
// use extension ForgotVC : LeoStoryBoarded{
//    static func leoStoryboarded() -> (String, String) {
//
//        return ("Main","ForgotVC")
//    }
//}
