//
//  LeoPopOver.swift
//  LeoPopOver
//
//  Created by Vijayvir Singh on 21/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//

import Foundation

import Foundation
import UIKit


class LeoPopOver : NSObject , UIPopoverPresentationControllerDelegate {
    enum Size {
        case custom(width: CGFloat , height: CGFloat )
        case size(size : CGSize )
        var value : CGSize {
            switch self {
            case .custom(let width, let height):
                return CGSize(width: width, height: height)
            case .size(let size):
                return size
            }
        }
    }
    
    func prepareNCWith( content : UIViewController , contentSize : Size? = .custom(width: 250 ,height: 250)  ,  sourceView: UIView? , sourceRect: CGRect ) -> UINavigationController? {
        let nC = UINavigationController(rootViewController: content)
        nC.modalPresentationStyle = .popover
        nC.navigationBar.isHidden = true
        nC.providesPresentationContextTransitionStyle = true
        nC.definesPresentationContext = true
        if let ppvc : UIPopoverPresentationController = nC.popoverPresentationController {
            if contentSize != nil {
            nC.preferredContentSize =  contentSize!.value
            }
            
            // CGSize(width: 250, height: 250)
            ppvc.sourceView = sourceView
            ppvc.sourceRect = sourceRect
            ppvc.delegate = self
            ppvc.permittedArrowDirections = .any
            nC.view.backgroundColor = .red
            //UIColor.init(white: 0.4, alpha: 0.45)
            return nC
        }
        return nil
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}


/*
 
 @IBAction func actionsomeAction(_ sender: UIButton) {
 
 
 
 let vcSome = self.storyboard?.instantiateViewController(withIdentifier: "V2ViewController") as! V2ViewController
 let some = LeoPopOver()
 let osme = some.prepareNCWith(content: vcSome,
 contentSize : .size(size: CGSize(width: 100, height: 100)),
 sourceView: sender,
 sourceRect: sender.frame)
 self.navigationController?.present(osme!, animated: true, completion: {})
 
 
 
 }
 
 */
