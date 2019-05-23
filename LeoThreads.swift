//
//  LeoThreads.swift
//  SharePhotoApp
//
//  Created by tecH on 21/05/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
func mainThreadLeo(_ callback : @escaping (() -> ())) {
    DispatchQueue.main.async {
        callback()
    }
}
