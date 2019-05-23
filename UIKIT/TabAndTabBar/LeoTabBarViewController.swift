//
//  CustomTapNewViewController.swift
//  Apex
//
//  Created by tecH on 12/03/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit
import IBAnimatable
import Nuke

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}


class LeoTabButton: UIButton {
    
    @IBInspectable var selectedColor  : UIColor = #colorLiteral(red: 0.9994125962, green: 0.4018217623, blue: 0, alpha: 1)
    @IBInspectable var normalColor  : UIColor = #colorLiteral(red: 0.9994125962, green: 0.4018217623, blue: 0, alpha: 1)

    @IBInspectable var normalBorderColor  : UIColor = #colorLiteral(red: 0.2945333719, green: 0.2947671115, blue: 0.2988897562, alpha: 1)
    @IBInspectable var selectedBorderColor  : UIColor = #colorLiteral(red: 0.2945333719, green: 0.2947671115, blue: 0.2988897562, alpha: 1)
    
    
    @IBInspectable var backgroundColorL  : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    @IBInspectable var  selectedImage : UIImage? =  nil
    @IBInspectable var  normalImage : UIImage = #imageLiteral(resourceName: "back")
    
    @IBOutlet weak var imageview: UIImageView?
    
    @IBOutlet weak var lbltitle: UILabel?
    
    @IBOutlet weak var viewBackGround: AnimatableView?
    
    @IBInspectable var identifierVC : String = ""
    
    //@IBOutlet weak var viewContiner: UIView?
    override func awakeFromNib() {
        lbltitle?.textColor = normalColor
        self.tintColor = selectedColor
        viewBackGround?.backgroundColor = backgroundColorL
    }
    
    override var isSelected: Bool {
        willSet {
            
        }
        
        /*
         case shake(repeatCount: Int)
         case pop(repeatCount: Int)
         case squash(repeatCount: Int)
         case flip(along: Axis)
         case morph(repeatCount: Int)
         case flash(repeatCount: Int)
         case wobble(repeatCount: Int)
         case swing(repeatCount: Int)
         public enum Axis: String {
         case x, y
         }
         */
        
        didSet {
            
            if isSelected {
                
                if selectedImage == nil {
                    imageview?.image = normalImage.maskWithColor(color: selectedColor)
                    lbltitle?.textColor = selectedColor
                    viewBackGround?.borderColor = selectedColor
                }else{
                    imageview?.image = selectedImage!.maskWithColor(color: selectedColor)
                    lbltitle?.textColor = selectedColor
                    viewBackGround?.borderColor = selectedColor
                }
                
               
                
            } else {
                
                imageview?.image = normalImage
                lbltitle?.textColor = normalColor
                viewBackGround?.borderColor = normalBorderColor
            }
            
        }
    }
    
}



class LeoTabBarViewController: UIViewController {
    @IBOutlet var btnsTabBar: [LeoTabButton]! = []
    
    @IBOutlet weak var containerView: UIView!
    
    var viewControllers : [UIViewController] = []
    
    static let initailIndex = 0
    
    @IBInspectable var previouslySelectedButtonTag : Int = initailIndex
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabDestinations()

        let selectedVC = viewControllers[previouslySelectedButtonTag]
        self.addChild(selectedVC)
        selectedVC.view.frame = containerView.bounds
        containerView.addSubview(selectedVC.view)
        selectedVC.didMove(toParent: self)
        
        _  =    btnsTabBar.map { (button) -> Void in
            button.isSelected = false
        }
        if btnsTabBar.count > 0 {
             btnsTabBar[0].isSelected = true
        }
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTabDestinations() {
//        guard let navMain1 = storyBoard(.Feed)?.instantiateViewController(withIdentifier: "NavFeed")
//            else { fatalError("Could not find navMain7 in storyboard") }
//        viewControllers.append(navMain1)
//        
//        guard let navMain2 = storyBoard(.Main)?.instantiateViewController(withIdentifier: "SYContactViewController")
//            else { fatalError("Could not find navMain7 in storyboard") }
//        viewControllers.append(navMain2)
//        
//        guard let navMain3 = storyBoard(.Post)?.instantiateViewController(withIdentifier: "SPCameraViewController")
//            else { fatalError("Could not find navMain7 in storyboard") }
//        viewControllers.append(navMain3)
//        
//        guard let navMain4 :  GroupViewController = storyBoard(.Post)?.instantiateViewController(withIdentifier: "GroupViewController") as! GroupViewController
//            
//            else { fatalError("Could not find navMain7 in storyboard") }
//        navMain4.isMultipleSelected = false
//        
//        viewControllers.append(navMain4)
//        
//   
//        
//        
//        guard let navMain5 = storyBoard(.Main)?.instantiateViewController(withIdentifier: "SYContactViewController")
//            else { fatalError("Could not find navMain7 in storyboard") }
//        viewControllers.append(navMain5)
        
        
        let storyboard =  self.storyboard

        for vc in btnsTabBar {
            if let navMain7 = storyboard?.instantiateViewController(withIdentifier: vc.identifierVC ) {
                viewControllers.append(navMain7)
            }
        }
    }
    
    
    
    @IBAction func actionTabButton(_ sender: LeoTabButton) {
        
        _ =  btnsTabBar.map { (button) -> Void in
            button.isSelected = false
        }
        sender.isSelected = true
     
        //self.selectedIndex = sender.tag
        
        
        let previousVC = viewControllers[previouslySelectedButtonTag]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        // Select new tab
        previouslySelectedButtonTag = sender.tag
        // Add new tab VC
        let selectedVC = viewControllers[sender.tag]
        self.addChild(selectedVC)
        selectedVC.view.frame = containerView.bounds
        containerView.addSubview(selectedVC.view)
        selectedVC.didMove(toParent: self)

    }
    

    @IBAction func pop(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
