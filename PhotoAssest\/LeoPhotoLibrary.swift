//
//  LeoPhotoLibrary.swift
//  iSpy
//
//  Created by tecH on 14/05/19.
//  Copyright © 2019 tecH. All rights reserved.
//
import  UIKit

import Foundation
import Photos
class LeoPhotoLibrary {
    
    struct Images {
        var image : UIImage
        
        var isSelected : Bool = false
        
        
    }
    
    static var share = LeoPhotoLibrary()
    var assets : [PHAsset] = []
    var type : PHAssetMediaType  = .image
    var images : [Images] = []
    var size : CGSize = CGSize(width: 100, height: 100)
    
    func withSize(_ size: CGSize ) ->LeoPhotoLibrary {
        self.size = size
        return self
    }
    
    
    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
            
        case .authorized:
            
            completionHandler(true)
            
        case .denied, .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    completionHandler(true)
                    
                case .denied, .restricted:
                    completionHandler(false)
                case .notDetermined:
                    completionHandler(false)
                }
            }
        case .restricted:
            completionHandler(false)
            
        }
        
    }
    func getAssets() -> LeoPhotoLibrary{
        
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: type , options: fetchOptions)
        assets.removeAll()
        let indexSet = IndexSet(0..<allPhotos.count)
        assets = allPhotos.objects(at: indexSet)
        if type == .image {
            images.removeAll()
            
            for object in getAssetThumbnail(assets: assets) {
                images.append(LeoPhotoLibrary.Images(image: object, isSelected: false))
            }
            
        }
        
        return self
    }
    
    func run(_ callback : (() -> ())? = nil ) {
        callback?()
    }
    
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
            })
        }
        
        return arrayOfImages
    }
}


/*
 LeoPhotoLibrary.share.requestForAccess { (isAcess) in
 if isAcess {
 LeoPhotoLibrary.share.getAssets().run()
 
 
 
 }
 }
 
 
 
 //  LeoPhotoLibrary.share.images.count
 
 */
