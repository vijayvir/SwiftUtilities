//
//  StoryboardType.swift
//  CubiShop
//
//  Created by tecH on 11/03/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit


enum  StoryboardType : String{
    case Main = "Main"
    case Post = "Post"
    case Token = "Token"
}
func storyBoard(_ type :  StoryboardType? = .Main) -> UIStoryboard? {
    
    if let storyboard = UIStoryboard(name: type!.rawValue, bundle: nil) as? UIStoryboard {
       return storyboard
     }
        
        return nil
}
extension  UIStoryboard {
    
    
    
}
//if let storyboard = UIStoryboard(name: "BusStoryboard", bundle: nil) as? UIStoryboard {
//    if  let vc = storyboard.instantiateViewController(withIdentifier: "BusAreaSearchViewController") as? BusAreaSearchViewController {
//        vc.callBackTap = { object in
//            self.pick = object
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//}
//}
