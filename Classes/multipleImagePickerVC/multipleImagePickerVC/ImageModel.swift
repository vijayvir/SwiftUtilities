//
//  ImageModel.swift
//  multipleImagePickerVC
//
//  Created by Apple on 29/07/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit
class CheckListitem: NSObject {
    var image = ""
    var checked = false
    
    func toggleCheck(){
        
        checked = !checked
    }
}
