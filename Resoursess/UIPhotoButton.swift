//  Created by vijay vir on 8/1/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import UIKit
import Foundation
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

let appNameUIPhotosButton = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

let rootFolder: String = "\(NSTemporaryDirectory())UIMultiplePhoto/"

class LeoUIPhotosButton: UIButton, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Outlets
    
    // MARK: Variables
    
    private var imagePaths = [String]()
    
    // This class have two option to select the images from Camera or Galler  . If isSingle is true It will select the an image and return to the class through delegate  or closure
    
    @IBInspectable var isSingle: Bool = true
    
    @IBInspectable var isAlertStyle: Bool = true
    
    @IBInspectable var  isGallery : Bool = true
    // Use this class to have multiple images .
    
    public var closureDidFinishPicking: ((_ images: [String]) -> Void)?
    // Use this class to have single image.
    public  var closureDidFinishPickingAnImage: ((_ image: [String]) -> Void)?
    
    public  var closureDidFinishPickingAnUIImage: ((_ image: UIImage) -> Void)?
    
    public  var closureDidTap: (() -> Void)?
    
    public  var closureDidTapCancel: (() -> Void)?
    
    // MARK: CLC
    
    @IBOutlet weak var viewcontoller :  UIViewController?
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        print(LeoUIPhotosButton.photoPath(), NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String, rootFolder)
        
        self.addTarget(self, action: #selector(addPhoto),
                       for: .touchUpInside)
        
    }
    
    // MARK: Actions
    
    // MARK: Functions
    
    class func removeCache() {
        
        let fileManger = FileManager.default
        // Delete 'subfolder' folder
        do {
            try fileManger.removeItem(atPath: rootFolder)
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
        
    }
    
    private class func photoPath() -> String {
        
        let fileManger = FileManager.default
        
        if !fileManger.fileExists(atPath: rootFolder) {
            do {
                try fileManger.createDirectory(atPath: "\(rootFolder)", withIntermediateDirectories: false, attributes: nil)
                
            } catch let error as NSError {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
        } else {
            print("file  exit ")
        }
        
        return rootFolder
    }
    
    @objc private func addPhoto() {
        
        
        imagePaths.removeAll()
        
        self.closureDidTap?()
        
        
        if isAlertStyle {
            var style : UIAlertController.Style = .actionSheet
            if UIDevice.current.userInterfaceIdiom == .pad {
                style = .alert
            }
            
            PhotoAlertHelper.alertView(title: appNameUIPhotosButton,
                                       message: "Select image.",
                                       preferredStyle: style,
                                       cancelTilte: "Cancel",
                                       otherButtons: "Camera", "Gallery",
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
                                            self.closureDidTapCancel?()
                                        }
                                        
            })
        } else {
            
            
            if !isGallery {
                
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    self.camera()
                    
                } else {
                    self.gallery()
                    
                }
                
            }else {
                self.gallery()
            }
        }
        
        
        
    }
    
    private func gallery() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        
        imagePicker.sourceType = .photoLibrary
        
        // let keywindow = UIApplication.shared.keyWindow
        
        //  let mainController = keywindow?.rootViewController
        
        viewcontoller?.present(imagePicker, animated: true, completion: nil)
    }
    
    private func camera() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        
        imagePicker.sourceType = .camera
        
        //  let keywindow = UIApplication.shared.keyWindow
        
        // let mainController = keywindow?.rootViewController
        
        viewcontoller?.present(imagePicker, animated: true, completion: nil)
    }
    
    
}
extension LeoUIPhotosButton {
    
    @discardableResult
    func withClosureDidTap(_ value : @escaping (() -> Void))-> LeoUIPhotosButton {
        closureDidTapCancel = value
        return self
    }
    @discardableResult
    func withClosureDidTapCancel(_ value : @escaping (() -> Void))-> LeoUIPhotosButton {
        closureDidTapCancel = value
        return self
    }
    @discardableResult
    func withClosureDidFinishPickingAnUIImage(_ value : @escaping ((_ image: UIImage) -> Void))-> LeoUIPhotosButton {
        closureDidFinishPickingAnUIImage = value
        return self
    }
    
    @discardableResult
    func withClosureDidFinishPickingAnImage(_ value : @escaping ((_ image: [String]) -> Void))-> LeoUIPhotosButton {
        closureDidFinishPickingAnImage = value
        return self
    }
    
    @discardableResult
    func withClosureDidFinishPicking(_ value : @escaping ((_ images: [String]) -> Void) )-> LeoUIPhotosButton {
        closureDidFinishPicking = value
        return self
    }
    
    
}

extension LeoUIPhotosButton {
    
    // MARK: ImagePicker view Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let filePath = URL(fileURLWithPath: LeoUIPhotosButton.photoPath() + "\(NSUUID().uuidString)").appendingPathExtension("jpg")
        
        imagePaths.append(filePath.path)
        
        let image = info[.originalImage] as! UIImage
        self.closureDidFinishPickingAnUIImage?(image)
        let imageData = image.jpegData(compressionQuality: 0.3)
        
        do {
            try imageData?.write(to: filePath, options: .atomic)
            
            closureDidFinishPickingAnImage?([filePath.path])
            
        } catch {
            print(error)
        }
        
        picker.dismiss(animated: true, completion: { [unowned self] () in
            
            if self.isSingle {
                
                self.closureDidFinishPicking?(self.imagePaths)
                
            } else {
                var style : UIAlertController.Style = .actionSheet
                if UIDevice.current.userInterfaceIdiom == .pad {
                    style = .alert
                }
                
                PhotoAlertHelper.alertView(imagesPath: self.imagePaths, message: "Would you like  to select more pictures ", preferredStyle: style,
                                           cancelTilte: "No",
                                           otherButtons: "Camera", "Gallery",
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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: { [unowned self] () in
            self.closureDidFinishPicking?(self.imagePaths)
        })
    }
    
}
class PhotoAlertHelper: UIAlertController {
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
            print(UIApplication.phototopViewController() ?? i)
            
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
        
        UIApplication.phototopViewController()?.present(alert, animated: true, completion: {
            
        })
        
    }
    
    class func alertView(title: String, message: String, preferredStyle: UIAlertController.Style, cancelTilte: String, otherButtons: String ..., comletionHandler: ((Swift.Int) -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for i in otherButtons {
            print(UIApplication.phototopViewController() ?? i)
            
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
        
        UIApplication.phototopViewController()?.present(alert, animated: true, completion: {
            
        })
        
    }
    
}

extension UIApplication {
    
    class func phototopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return phototopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return phototopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return phototopViewController(controller: presented)
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
