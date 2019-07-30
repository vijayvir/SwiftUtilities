//  Created by vijay vir on 8/1/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit
import Foundation
import Photos
import MobileCoreServices
/**
 - Author: Vijavir
 */
// last updations on Apple Swift version 3.0.1 (swiftlang-800.0.58.6 clang-800.0.42.1)
/*
 Main purpose of this class is to store images in file managers and store paths in array and return that array of paths*  to class through  delegate  or closure
 paths*  :  images are going to save in /tmp/UIMultiplePhoto/  of app
 to empty the UIMultiplePhoto follder use class function : removeCache()
 */
// Use this below line to .plist .Why? To have access from the user to open the Gallery or Camera
/*
 <key>NSCameraUsageDescription</key>
 <string>Access needed to use your camera.</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>Access needed to photo gallery.</string>
 
 
 <key>UIFileSharingEnabled</key>
 <true/>
 <key>LSSupportsOpeningDocumentsInPlace</key>
 <true/>
 
 
 */
/* Working of the class
 
 Ist : make the outlet in class
 @IBOutlet weak var btnPhoto: UIPhotosButton!
 2nd : use the closure or delegate in view Did load method .
 btnPhoto.closureDidFinishPickingAnImage = { image in
 print(image)
 DispatchQueue.main.async {
 let url : URL = URL(fileURLWithPath: image.first!)
 Nuke.loadImage(with: url, into: self.imgeVUerPic)
 }
 }
 */

extension FileManager {
    class func documentsDir() -> String {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.path
        
        
        
        
//        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
//        return paths[0]
    }
    
    class func cachesDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    
    // NSTemporaryDirectory()
}


fileprivate  let appNameUIPhotosButtonLeoFiles = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

 let rootFolderLeoFiles: String = "\(FileManager.documentsDir())/LeoFilesUIButton/"
//fileprivate let rootFolderLeoFiles: String = "\(FileManager.NSTemporaryDirectory())/LeoFilesUIButton/"

class LeoFilesUIButton: UIButton, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Outlets
    
    // MARK: Variables
    
    private var imagePaths = [String]()
    
    // This class have two option to select the images from Camera or Galler  . If isSingle is true It will select the an image and return to the class through delegate  or closure
    
    @IBInspectable var isSingle: Bool = true
    
    // Use this class to have multiple images .
    
     private var folderName: String? =  nil
    
    final  public  func withFolderName(_  value : String) -> LeoFilesUIButton{
        
        self.folderName = value
        return self
        
    }
    
    public var closureDidFinishPicking: ((_ images: [String]) -> Void)?
    
    // Use this class to have single image.
    
    public  var closureDidFinishPickingImagesWithPath: ((_ image: [String]) -> Void)?
    private   var closureDidTapCancel: (() -> Void)?
    private  var closureDidFinishPickingAnUIImage: ((_ image: UIImage , _ file: (directory: String, filenameOnly: String, ext: String) ) -> Void)?
    
    public  var closureDidTap: (() -> Void)?
    var popOver:UIPopoverController?
    
    
    
    private  var closureDidDocumentMenuWasCancelled: (() -> Void)?
    private  var closureDidPickDocumentAt: ((_ file: (directory: String, filenameOnly: String, ext: String) ) -> Void)?
    
    // MARK: CLC
    
    @IBOutlet weak var viewcontoller :  UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        print(LeoFilesUIButton.photoPath(folderName), NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String, rootFolderLeoFiles)
        
        self.addTarget(self, action: #selector(addPhoto),
                       for: .touchUpInside)
        
        
        
        
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }

    // MARK: Modifier
    
    func withClosureDidTapCancelImagePicker( _ closure :  @escaping   (() -> Void)  ) -> LeoFilesUIButton {
        
        closureDidTapCancel = closure
        return self
        
    }
    func withClosureDidFinishPickingAnUIImaget(_ closure :  @escaping   ( (  UIImage , (directory: String, filenameOnly: String, ext: String)  ) -> Void)   ) -> LeoFilesUIButton {
        
        closureDidFinishPickingAnUIImage = closure
        return self
        
    }
    
    
    func withClosureDidPickDocumentAt(_ closure :  @escaping   ( ( (directory: String, filenameOnly: String, ext: String)  ) -> Void)   ) -> LeoFilesUIButton {
        
        closureDidPickDocumentAt = closure
        return self
        
    }
    
    func withClosureDidDocumentMenuWasCancelled( _ closure :  @escaping   (() -> Void)  ) -> LeoFilesUIButton {
        
        closureDidDocumentMenuWasCancelled = closure
        return self
        
    }
    
    func withStop(){
        
    }
    
    class func removeCache() {
        
        let fileManger = FileManager.default
        // Delete 'subfolder' folder
        do {
            try fileManger.removeItem(atPath: rootFolderLeoFiles)
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
    }
    
    private class func photoPath(_ nestedFolder : String? = nil  ) -> String {
        
        let fileManger = FileManager.default
        var some =  rootFolderLeoFiles
        
        if nestedFolder != nil {
            some =  rootFolderLeoFiles + nestedFolder! + "/"
        }
  
        if !fileManger.fileExists(atPath: some) {
            do {
                try fileManger.createDirectory(atPath: "\(some)", withIntermediateDirectories: false, attributes: nil)
                
            } catch let error as NSError {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
        } else {
            print("file  exit ")
        }
        
        return some
    }
    
    
    
    @objc private func addPhoto() {
        imagePaths.removeAll()
        
        self.closureDidTap?()
        var style : UIAlertController.Style = .actionSheet
        if UIDevice.current.userInterfaceIdiom == .pad {
            style = .alert
        }
        
        LeoFilesAlertHelper.alertView(title: appNameUIPhotosButtonLeoFiles,
                                      message: "Select File from options.",
                                      preferredStyle: style,
                                      cancelTilte: "Cancel".leoLocalized(),
                                      otherButtons: "Camera".leoLocalized(), "Gallery".leoLocalized() , "Document".leoLocalized(),
                                      comletionHandler: { (index: Swift.Int) in
                                        
                                        print(index)
                                        
                                        if index == 0 {
                                            
                                            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                                                self.camera()
                                                
                                            } else {
                                                self.gallery()
                                                
                                            }
                                            
                                        } else if index == 1 {
                                            self.gallery()
                                        } else if index == 2 {
                                            self.document()
                                        }else if index == 3 {
                                            self.closureDidTapCancel?()
                                        }
                                        
        })
        
    }
    
    
    private func document() {
        
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypePDF)], in: .import)
        
        documentPicker.delegate = self
        
        
        
        viewcontoller?.present(documentPicker, animated: true, completion: nil)
    }
    
    private func gallery() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        
        imagePicker.sourceType = .photoLibrary
        if UIDevice.current.userInterfaceIdiom == .pad {
                        //let keywindow = UIApplication.shared.keyWindow
        }
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            
            
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
  
            
  
            
            OperationQueue().addOperation({
                print("WORKING...")
                OperationQueue.main.addOperation({
                    self.viewcontoller?.present(imagePicker, animated: false, completion: nil)
                    
                    let popoverPresentationController = imagePicker.popoverPresentationController
                    popoverPresentationController?.sourceView = self
                    
                })
            })
            
            
        }
        else
        {
            OperationQueue().addOperation({
                print("WORKING...")
                OperationQueue.main.addOperation({
                    self.viewcontoller?.present(imagePicker, animated: false, completion: nil)
                })
            })
            
            
        }
        
        
        //  let mainController = keywindow?.rootViewController
        
    
    }
    
    private func camera() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        
        imagePicker.sourceType = .camera
   
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            
            
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            
            
            
            
            OperationQueue().addOperation({
                print("WORKING...")
                OperationQueue.main.addOperation({
                    self.viewcontoller?.present(imagePicker, animated: false, completion: nil)
                    
                    let popoverPresentationController = imagePicker.popoverPresentationController
                    popoverPresentationController?.sourceView = self
                    
                })
            })
            
            
        }
        else
        {
            OperationQueue().addOperation({
                print("WORKING...")
                OperationQueue.main.addOperation({
                    self.viewcontoller?.present(imagePicker, animated: false, completion: nil)
                })
            })
            
            
        }

        //   let mainController = keywindow?.rootViewController
        
     
    }
    
    // MARK: ImagePicker view Delegate
    
   
    
    
internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let filePath = URL(fileURLWithPath: LeoFilesUIButton.photoPath(folderName) + "\(NSUUID().uuidString)").appendingPathExtension("jpg")
        
        imagePaths.append(filePath.path)
        let some = splitFilename(str: "\(filePath)")
        
       // print(filePath.path)
        
        let image = info[.originalImage] as! UIImage
    
        let imageData = image.jpegData(compressionQuality: 0.1)
        
        do {
            try imageData?.write(to: filePath)
            self.closureDidFinishPickingAnUIImage?(image, (filePath.path ,some.filenameOnly , some.ext  ))
            
            closureDidFinishPickingImagesWithPath?([filePath.path])
            

            viewcontoller?.dismiss(animated: false, completion: { [unowned self] () in
                
                if self.isSingle {
                    
                    self.closureDidFinishPicking?(self.imagePaths)
                    
                } else {
                    var style : UIAlertController.Style = .actionSheet
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        style = .alert
                    }
                    
                    LeoFilesAlertHelper.alertView(imagesPath: self.imagePaths, message: "Would you like  to select more pictures ", preferredStyle: style,
                                                  cancelTilte: "No",
                                                  otherButtons: "Camera".leoLocalized(), "Gallery".leoLocalized(),
                                                  comletionHandler: { [unowned self] (index: Swift.Int) in
                                                    
                                                    print(index)
                                                    
                                                    if index == 0 {
                                                        
                                                        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                                                            self.camera()
                                                        } else {
                                                            self.gallery()
                                                        }
                                                    } else if index == 1 {
                                                        self.gallery()
                                                    } else if index == 2 {
                                                        self.closureDidFinishPicking?(self.imagePaths)
                                                    }
                    })
                }
            })
            
        } catch {
            print(error)
        }
        
   
    }
    
      @objc  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: { [unowned self] () in
            self.closureDidFinishPicking?(self.imagePaths)
        })
    }
}

extension LeoFilesUIButton : UIDocumentMenuDelegate {
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        documentPicker.present(documentPicker, animated: true, completion: nil)
    }
    
    public func documentMenuWasCancelled(_ documentMenu: UIDocumentMenuViewController) {
        
    }
}

extension  LeoFilesUIButton :    UIDocumentPickerDelegate {
    //MARK: Split FileName String
    func splitFilename(str: String) -> (directory: String, filenameOnly: String, ext: String) {
        let url = URL(fileURLWithPath: str)
        //  self.btnPdf.backgroundColor = UIColor.white
        //  self.btnPdf.setTitle("\(url.deletingPathExtension().lastPathComponent).\(url.pathExtension)", for: .normal)
        
        return (url.deletingLastPathComponent().path, url.deletingPathExtension().lastPathComponent, url.pathExtension)
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        
        let myURL = url as URL
        
        print("import result : \(myURL)")
        let some = splitFilename(str: "\(myURL)")
        
        //var tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let filePath = URL(fileURLWithPath: LeoFilesUIButton.photoPath(folderName) +  "\(NSUUID().uuidString)" ).appendingPathExtension(some.ext)
        
        
        // Apend filename (name+extension) to URL
        //        tempURL.appendPathComponent(url.lastPathComponent)
        do {
            // If file with same name exists remove it (replace file with new one)
            if FileManager.default.fileExists(atPath: filePath.path) {
                try FileManager.default.removeItem(atPath: filePath.path)
            }
            // Move file from app_id-Inbox to tmp/filename
            try FileManager.default.moveItem(atPath: url.path, toPath: filePath.path)
            
            closureDidPickDocumentAt?(( filePath.path , filePath.deletingPathExtension().lastPathComponent , some.ext ) )
            
            
            //            self.arrayDoc.append(tempURL)
            //            self.collectionView.reloadData()
            //            self.flurl = tempURL
        } catch {
            print(error.localizedDescription)
            
        }
        
    }
    
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
        closureDidDocumentMenuWasCancelled?()
    }
    
    
    
}


class LeoFilesAlertHelper: UIAlertController {
    // make sure you have navigation  view controller
    
    class func alertView(imagesPath: [String], message: String, preferredStyle: UIAlertController.Style, cancelTilte: String, otherButtons: String ..., comletionHandler: ((Swift.Int) -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n", message: message, preferredStyle: preferredStyle)
        
        let margin: CGFloat = 10.0
        
        let height: CGFloat = 120.0
        
        let rect = CGRect(x: margin, y: margin, width: alert.view.bounds.size.width - margin * 4.0, height: height)
        let customView = UIView(frame: rect)
        
        // customView.backgroundColor = .green
        alert.view.addSubview(customView)
        
        let rectofScrollView = CGRect(x: 0, y: 0, width: customView.bounds.size.width, height: customView.bounds.size.height)
        let scrollView = UIScrollView(frame: rectofScrollView)
        scrollView.backgroundColor = .gray
        customView.addSubview(scrollView)
        
        for (index, filepath) in imagesPath.enumerated() {
            
            let imagev = UIImageView(frame: CGRect(x: height * CGFloat(index) + (margin * CGFloat(index + 1)), y: margin, width: height, height: height - (2 * margin)))
            
            imagev.image = UIImage(named: filepath)
            
            scrollView.addSubview(imagev)
            
        }
        
        // 4
        scrollView.contentSize = CGSize(width: CGFloat(imagesPath.count) * height + (margin * CGFloat(imagesPath.count + 1)), height: height)
        
        print("images path are ", imagesPath)
        
        for i in otherButtons {
            print(UIApplication.leoFileTopViewController() ?? i)
            
            alert.addAction(UIAlertAction(title: i, style: UIAlertAction.Style.default,
                                          handler: { (action: UIAlertAction!) in
                                            
                                            comletionHandler?(alert.actions.index(of: action)!)
                                            
            }
            ))
            
        }
        if (cancelTilte as String?) != nil {
            alert.addAction(UIAlertAction(title: cancelTilte, style: UIAlertAction.Style.destructive,
                                          handler: { (action: UIAlertAction!) in
                                            
                                            comletionHandler?(alert.actions.index(of: action)!)
                                            
            }
            ))
        }
        
        UIApplication.leoFileTopViewController()?.present(alert, animated: true, completion: {
            
        })
        
    }
    
    class func alertView(title: String, message: String, preferredStyle: UIAlertController.Style, cancelTilte: String, otherButtons: String ..., comletionHandler: ((Swift.Int) -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for i in otherButtons {
            print(UIApplication.leoFileTopViewController() ?? i)
            
            alert.addAction(UIAlertAction(title: i, style: UIAlertAction.Style.default,
                                          handler: { (action: UIAlertAction!) in
                                            
                                            comletionHandler?(alert.actions.index(of: action)!)
                                            
            }
            ))
            
        }
        if (cancelTilte as String?) != nil {
            alert.addAction(UIAlertAction(title: cancelTilte, style: UIAlertAction.Style.destructive,
                                          handler: { (action: UIAlertAction!) in
                                            
                                            comletionHandler?(alert.actions.index(of: action)!)
                                            
            }
            ))
        }
        
        UIApplication.leoFileTopViewController()?.present(alert, animated: true, completion: {
            
        })
        
    }
    
}

extension UIApplication {
    
    class func leoFileTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return leoFileTopViewController(controller: navigationController.visibleViewController)
        }
    
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return leoFileTopViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return leoFileTopViewController(controller: presented)
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
