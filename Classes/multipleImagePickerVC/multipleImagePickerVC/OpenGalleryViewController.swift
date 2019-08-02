//
//  OpenGalleryViewController.swift
//  multipleImagePickerVC
//
//  Created by Apple on 29/07/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Photos






class SelectedPhotos: UICollectionViewCell{
    
    @IBOutlet weak var selectedImage: UIImageView!
    
}

class OpenGalleryViewController: UIViewController{
    
    var closer = [UIImage]()
    
    @IBAction func actionOpenGalleryBtn(_ sender: Any) {
        
    
        
        
        
//        LeoPhotoLibrary.share.requestForAccess { (status ) in
//
//            if status{
//                     print( LeoPhotoLibrary.share.withSize(self.view.bounds.size).getAssets().images)
//            }else {
//
//                LeoPhotoLibrary.leoStatus( denied: {
//                    LeoPhotoLibrary.openSettingsWithAlert()
//                })
//
//
//            }}
//

        
        
        let osme = LeoPhotoLibraryViewController()
        osme.withSelectedImages { (images) in
            self.closer = images
            self.collectionOfSeletedPhotos.reloadData()
            
        }
        
       if  self.navigationController != nil {
      self.navigationController?.pushViewController(osme, animated: true)
       }else {
        self.present(osme, animated: true) {
            
        }
        }
    
        
     
        

    }
    

    @IBOutlet weak var collectionOfSeletedPhotos: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionOfSeletedPhotos.delegate = self
        collectionOfSeletedPhotos.dataSource = self
       
    }
}

extension OpenGalleryViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return closer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionOfSeletedPhotos.dequeueReusableCell(withReuseIdentifier: "SelectedPhotos", for: indexPath) as! SelectedPhotos
        
          cell.selectedImage.image = closer[indexPath.row]
      
        
        return cell
    }
    
    
}
