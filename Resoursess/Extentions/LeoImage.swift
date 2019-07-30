//
//  LeoImage.swift
//  iSpy
//
//  Created by tecH on 19/07/19.
//  Copyright © 2019 tecH. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    func leoData(compressionQuality: CGFloat) -> Data {
    let imageData = self.jpegData(compressionQuality: compressionQuality)
    return imageData!
    }
    
    func leoBase64String(compressionQuality: CGFloat) -> String {
        
        let imageData = self.jpegData(compressionQuality: compressionQuality)
        
        let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return base64String ?? ""
        
    }
  class   func leoBase64StringToImage(_ base64String: String) -> UIImage? {
        
    if  let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0)) {
          let decodedimage = UIImage(data: decodedData as Data)
        return decodedimage
    }
        
    
        
        return nil
        
    }
    func leoResizeImage( targetSize: CGSize) -> UIImage {
        
    let size = self.size
    
    let widthRatio  = targetSize.width  / self.size.width
    let heightRatio = targetSize.height / self.size.height

        
    var newSize: CGSize
    if(widthRatio > heightRatio) {
    newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
    newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
        
    }
    
    
    
    
    
    
    

//    func leoCropToRect(rect: CGRect!) -> UIImage? {
//        // Correct rect size based on the device screen scale
//        let scaledRect = CGRectMake(rect.origin.x * self.scale, rect.origin.y * self.scale, rect.size.width * self.scale, rect.size.height * self.scale);
//        // New CGImage reference based on the input image (self) and the specified rect
//        let imageRef = CGImageCreateWithImageInRect(self.CGImage, scaledRect);
//        // Gets an UIImage from the CGImage
//        let result = UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
//        // Returns the final image, or NULL on error
//        return result;
//    }

}
