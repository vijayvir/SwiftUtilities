//
//  MultipleImagePickerVC.swift
//  multipleImagePickerVC
//
//  Created by Apple on 26/07/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MultipleImagePickerVC: UIViewController{

    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.imagePicker = self imagePicker(presentationController: self, delegate: self)
    }
    
    
    @IBAction func selectImagePicker(_ sender: Any) {
        self.imagePicker.present(sender as! UIViewController, animated: true)
    }
    
}
extension MultipleImagePickerVC: UIImagePickerControllerDelegate{
    
    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}

    



