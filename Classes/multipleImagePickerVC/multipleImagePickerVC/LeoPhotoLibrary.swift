//
//  LeoPhotoLibrary.swift
//  iSpy
//
//  Created by tecH on 14/05/19.
//  Copyright © 2019 VijayVir Singh. All rights reserved.
//

/*
 <key>NSPhotoLibraryUsageDescription</key>
 <string>Access needed to photo gallery.</string>
 */
/*
 This class is used for the selecting the images from the Photo Gallery of the phone
 */

import  UIKit
import Photos
import Foundation

let LeoPLAppName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
class LeoPhotoLibrary {
    
    enum Status {
        
        case notDetermined // User has not yet made a choice with regards to this application
        
        case restricted // This application is not authorized to access photo data.
        
        // The user cannot change this application’s status, possibly due to active restrictions
        //   such as parental controls being in place.
        case denied // User has explicitly denied this application access to photos data.
        
        case authorized // User has authorized this application to access photos data.
        
    }
    
    class Images {
        var image : UIImage
        
        var isSelected : Bool = false
        init(image : UIImage , isSelected :  Bool = false ) {
            self.image = image
            self.isSelected = isSelected
        }
        
        
    }
    
 static var share = LeoPhotoLibrary()
    private var assets : [PHAsset] = []
    private  var type : PHAssetMediaType  = .image
    
    var images : [Images] = []
   
    private  var size : CGSize = CGSize(width: 100, height: 100)
    
    private  init() {
        
    }
    
    
    private func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
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
    
    //Mark: To use
    func withSize(_ size: CGSize ) ->LeoPhotoLibrary {
        self.size = size
        return self
    }
 
  
    
    class  func openSettingsWithAlert() {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: LeoPLAppName, message: "Please enable the \(LeoPLAppName) to access the Photo from settings screen.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "GO", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction!) in
         
                
                LeoPhotoLibrary.openSettings()
        
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { (_: UIAlertAction!) in
            
            }))
            
            UIApplication.leoPhotoLibarayTVC()?.present(alert, animated: true, completion: {
            })
        }
        
        
        
   
    }
    
    
   class  func openSettings() {
        
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                 UIApplication.shared.open(settingsUrl)
        }
   

    }
    
    
    @discardableResult
    class  func leoStatus( authorized :(()-> Void )? = nil ,
                           restricted :(()-> Void )? = nil  ,
                           notDetermined :(()-> Void )? = nil ,
                           denied :(()-> Void )? = nil ) ->LeoPhotoLibrary.Status {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .notDetermined:
                notDetermined?()
              return LeoPhotoLibrary.Status.notDetermined
        case .restricted:
                restricted?()
              return LeoPhotoLibrary.Status.restricted
        case .denied:
               denied?()
              return LeoPhotoLibrary.Status.denied
        case .authorized:
                authorized?()
              return LeoPhotoLibrary.Status.authorized
     
        @unknown default:
               return LeoPhotoLibrary.Status.notDetermined
        }
        
        
        
     
    }
    
    
func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
    
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
            
        case .authorized:

            DispatchQueue.main.async {
                  completionHandler(true)
            }
            
   

        case .denied, .notDetermined:
            PHPhotoLibrary.requestAuthorization { statusInner in
                switch statusInner {
                case .authorized:
                    
                    DispatchQueue.main.async {
                        completionHandler(true)
                    }
           
                case .denied, .restricted:
                    DispatchQueue.main.async {
                        completionHandler(false)
                    }
                    
                 
                case .notDetermined:
                    DispatchQueue.main.async {
                        completionHandler(false)
                    }
                @unknown default:
                        print()
                }
            }
        case .restricted:
            DispatchQueue.main.async {
                completionHandler(false)
            }

        @unknown default:
            print()
    }
        
    }
    @discardableResult
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
    

}
extension UIApplication {
    class func leoPhotoLibarayTVC(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return leoPhotoLibarayTVC(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return leoPhotoLibarayTVC(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return leoPhotoLibarayTVC(controller: presented)
        }
        
        // need R and d
        //        if let top = UIApplication.shared.delegate?.window??.rootViewController
        //        {
        //            let nibName = "\(top)".characters.split{$0 == "."}.map(String.init).last!
        //
        //            print(  self,"    d  ",nibName)
        //
        //            return top
        //        }
        return controller
    }
}

//MARK :  UIView Functionality
class LeoPhotoLibraryViewController : UIViewController {
    var images : [LeoPhotoLibrary.Images] = []
    private  var isSingleSelect : Bool = true
    private var closureDone : (([UIImage])-> Void)?
    private   var height: CGFloat  =   64
    
     @discardableResult
    func  withSigleSelection( active : Bool = false )->LeoPhotoLibraryViewController{
        self.isSingleSelect = active
            return self
    }
    
    @discardableResult
    func withSelectedImages(_ value : @escaping (([UIImage])-> Void) ) ->LeoPhotoLibraryViewController{
        closureDone = value
        
        return self
        
    }
    var collectionView : UICollectionView!
    override func viewDidLoad() {
        
        height  = self.navigationController?.navigationBar.frame.height ??  64
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
     
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width/3.5, height: self.view.bounds.width/3.5)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        self.collectionView = UICollectionView(frame: CGRect(x: 0,
                                                             y: height + UIApplication.shared.statusBarFrame.height + 2,
                                                             width: self.view.bounds.width - 10 ,
                                                             height:  self.view.bounds.height - 4 ), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isSpringLoaded = true
    
        collectionView.backgroundColor = .clear
        collectionView.register(LeoPhotoLibraryCollectionViewCell.self, forCellWithReuseIdentifier: "LeoPhotoLibraryCollectionViewCell")
        self.view.addSubview(collectionView)

         addNavigationBar()
     
     
        LeoPhotoLibrary.share.requestForAccess { (status ) in
            
            if status{
                self.images.removeAll()
                self.collectionView.reloadData()
                self.images = LeoPhotoLibrary.share.withSize(self.view.bounds.size).getAssets().images
               self.collectionView.reloadData()
            }else {
                
                LeoPhotoLibrary.leoStatus( denied: {
                    LeoPhotoLibrary.openSettingsWithAlert()
                })
                
                
            }}
        self.images =  LeoPhotoLibrary.share.images.map({ (image) -> LeoPhotoLibrary.Images in
            image.isSelected = false
            return image
        })
        
        
          self.collectionView.reloadData()
    }
    
    
    private func makeNav(){
        let statusBarHeight = UIApplication.shared.statusBarFrame.height;
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.clear
        //  navbar.delegate = self as? UINavigationBarDelegate
        
        let add = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionAdd))
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(actionClear))
        
        
        
        
        
        
        let navItem = UINavigationItem()
        navItem.title = "Gallery"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(actionBack))
        navItem.rightBarButtonItems =  [clear ,add ]
        navbar.items = [navItem]
        
        view.addSubview(navbar)
        
    }
    private func addNavigationBar(){
       
        if navigationController != nil {
            if self.navigationController!.navigationBar.isHidden {
            makeNav()
                
                
            }else {
                
                let add = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionAdd))
                let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(actionClear))
                
                navigationItem.rightBarButtonItems = [clear,add]
                navigationItem.title = "Gallery"

            }
            
        }else {
            makeNav()
            
            
            
            
            

        }
        
     
        
     
    
    }
    
     @objc func actionBack(){
        if  self.navigationController != nil {
            
            self.navigationController?.popViewController(animated: true)
        }else {
            self.dismiss(animated: true) {
                
            }
        }
        
     
        
        
    }
    @objc func actionAdd(){
        
        let some = images.filter { (image) -> Bool in
            return image.isSelected
            }.map { ( image) -> UIImage in
                return image.image
                
        }
       closureDone?(some)
        
       actionBack()
  
        
    }
       @objc  func actionClear(){
        _ =   images.map { ( image) -> Void in
            image.isSelected = false
        }
        collectionView.reloadData()
    }

}
extension LeoPhotoLibraryViewController : UICollectionViewDelegate {
    
}

extension LeoPhotoLibraryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeoPhotoLibraryCollectionViewCell", for: indexPath) as! LeoPhotoLibraryCollectionViewCell
        cell.configure(element: images[indexPath.row])
        cell.closureDidTap = { element in
            
            if self.isSingleSelect {
                for image in self.images {
                    
                    image.isSelected = false
                    
                    
                }
                
                element.isSelected = true
                self.collectionView.reloadData()
                
            }
            
          
            
        }
        return cell
    }
}


class LeoPhotoLibraryCollectionViewCell : UICollectionViewCell{
    
    var element :  LeoPhotoLibrary.Images?
    
    var closureDidTap : ((LeoPhotoLibrary.Images)-> Void)?
    var imageView : UIImageView?
    var btnTap : UIButton!
    
    
    func configure(element : LeoPhotoLibrary.Images) {
        self.element = element
        if imageView == nil {
            imageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: self.contentView.bounds.width  - 10, height: self.contentView.bounds.height - 10))
           // imageView?.contentMode = .scaleAspectFit
           
            imageView?.center =  self.contentView.center
            imageView?.backgroundColor = .white
            imageView?.image = element.image
            self.contentView.addSubview(imageView!)
            
            btnTap = UIButton(frame: self.contentView.bounds)
        
            btnTap.addTarget(self, action: #selector(actionTap), for: .touchUpInside)
            
            if self.element!.isSelected {
                
                self.backgroundColor = .blue
            }else {
                self.backgroundColor = .white
            }
            
            self.contentView.addSubview(btnTap!)
            
            
        }else {
            imageView?.image = element.image
            
            
            btnTap.addTarget(self, action: #selector(actionTap), for: .touchUpInside)
            
            if self.element!.isSelected {
                
                self.backgroundColor = .blue
            }else {
                self.backgroundColor = .white
            }
            
            
            
        }
        
        
        
    }
    
    @objc func actionTap(){
         self.element?.isSelected = !self.element!.isSelected
        
        if self.element!.isSelected {
      
               self.backgroundColor = .blue
        }else {
               self.backgroundColor = .white
        }
        
        closureDidTap?(self.element!)
    }
}


//TODO: Get  the images from UIPhoto

/*   Get the images from the Gallery
 LeoPhotoLibrary.share.requestForAccess { (status ) in
 
 if status{
 print( LeoPhotoLibrary.share.withSize(self.view.bounds.size).getAssets().images)
 }else {
 
 LeoPhotoLibrary.leoStatus( denied: {
 LeoPhotoLibrary.openSettingsWithAlert()
 })
 
 
 }}

 
 
 
 
 //  LeoPhotoLibrary.share.images.count
 
 */



//TODO:  Usage of View Controller
/*
 
 let osme = LeoPhotoLibraryViewController()
 osme.withSelectedImages { (images) in
 self.closer = images
 self.collectionOfSeletedPhotos.reloadData()
 
 }.withSigleSelection(active: true)
 
 if  self.navigationController != nil {
 self.navigationController?.pushViewController(osme, animated: true)
 }else {
 self.present(osme, animated: true) {
 
 }
 }
 */
