//
//  LeoZoom.swift
//  LeoImageTap
//
//  Created by tecH on 22/07/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit





class LeoZoomViewController : UIViewController {
    
    private var imageView : UIImageView!
    var image : UIImage?
    var tintColor: UIColor!
    var  closureDidTapOnCross : (()-> Void )?
    
    func configure( image : UIImage?,  tintColor: UIColor = .blue , closureDidTapOnCross : @escaping (()-> Void )  ) {
        self.image = image
        self.tintColor = tintColor
        self.closureDidTapOnCross = closureDidTapOnCross
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = .white
        
        
     
        let scrollImg: UIScrollView = UIScrollView(frame: self.view.bounds)
        scrollImg.delegate = self
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
       // scrollImg.backgroundColor = .red
        scrollImg.minimumZoomScale = 0.10
        scrollImg.maximumZoomScale = 100.0
     
     
        
        self.view.addSubview(scrollImg)
        
        
        imageView = UIImageView(frame:scrollImg.bounds)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        scrollImg.addSubview(imageView!)
        
        
        
        let button: UIButton = UIButton(type: .system)
        button.tintColor = tintColor
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.setImage(LeoZoomButtons.imageOfCross, for: .normal)
        button.addTarget(self, action: #selector(self.actionCross), for: .touchUpInside)
    }
    
    @objc func actionCross(sender: AnyObject) {
           closureDidTapOnCross?()
        self.dismiss(animated: true) {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
 
    
}

extension LeoZoomViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let subView = scrollView.subviews[0] // get the image view
        
        let someX = scrollView.bounds.size.width - scrollView.contentSize.width
        
        let someY = scrollView.bounds.size.height - scrollView.contentSize.height
        
        let offsetX = max( someX * CGFloat(0.5), 0.0)
        let offsetY = max(someY * CGFloat(0.5), 0.0)
        
        
        subView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
  
}

private var LZAssociatedObjectHandle: UInt8 = 25
public enum LZClosureActions : Int{
    case none = 0
    case tap = 1
    case swipe_left = 2
    case swipe_right = 3
    case swipe_down = 4
    case swipe_up = 5
}
public struct LZClosure {
    typealias emptyCallback = ()->()
    static var actionDict = [Int:[LZClosureActions : emptyCallback]]()
    static var btnActionDict = [Int:[String: emptyCallback]]()
}


extension UIImageView   {
    
    var closureId:Int{
        get {
            let value = objc_getAssociatedObject(self, &LZAssociatedObjectHandle) as? Int ?? Int()
            return value
        }
        set {
            objc_setAssociatedObject(self, &LZAssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public func actionHandleBlocks(_ type : LZClosureActions = .none,action:(() -> Void)? = nil) {
        
        if type == .none{
            return
        }
        var actionDict : [LZClosureActions : LZClosure.emptyCallback]
        if self.closureId == Int(){
            self.closureId = LZClosure.actionDict.count + 1
            LZClosure.actionDict[self.closureId] = [:]
        }
        if action != nil {
            actionDict = LZClosure.actionDict[self.closureId]!
            actionDict[type] = action
            LZClosure.actionDict[self.closureId] = actionDict
        } else {
            let valueForId = LZClosure.actionDict[self.closureId]
            if let exe = valueForId![type]{
                exe()
            }
        }
    }
    
    @objc public func triggerTapActionHandleBlocks() {
        self.actionHandleBlocks(.tap)
    }
    @objc public func triggerSwipeLeftActionHandleBlocks() {
        self.actionHandleBlocks(.swipe_left)
    }
    @objc public func triggerSwipeRightActionHandleBlocks() {
        self.actionHandleBlocks(.swipe_right)
    }
    @objc public func triggerSwipeUpActionHandleBlocks() {
        self.actionHandleBlocks(.swipe_up)
    }
    @objc public func triggerSwipeDownActionHandleBlocks() {
        self.actionHandleBlocks(.swipe_down)
    }
    
    public func leoAddAction(for type: LZClosureActions ,Action action:@escaping() -> Void){
        
        self.isUserInteractionEnabled = true
        self.actionHandleBlocks(type,action:action)
        switch type{
        case .none:
            return
        case .tap:
            let gesture = UITapGestureRecognizer()
            gesture.addTarget(self, action: #selector(triggerTapActionHandleBlocks))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        case .swipe_left:
            let gesture = UISwipeGestureRecognizer()
            gesture.direction = UISwipeGestureRecognizer.Direction.left
            gesture.addTarget(self, action: #selector(triggerSwipeLeftActionHandleBlocks))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        case .swipe_right:
            let gesture = UISwipeGestureRecognizer()
            gesture.direction = UISwipeGestureRecognizer.Direction.right
            gesture.addTarget(self, action: #selector(triggerSwipeRightActionHandleBlocks))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        case .swipe_up:
            let gesture = UISwipeGestureRecognizer()
            gesture.direction = UISwipeGestureRecognizer.Direction.up
            gesture.addTarget(self, action: #selector(triggerSwipeUpActionHandleBlocks))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        case .swipe_down:
            let gesture = UISwipeGestureRecognizer()
            gesture.direction = UISwipeGestureRecognizer.Direction.down
            gesture.addTarget(self, action: #selector(triggerSwipeDownActionHandleBlocks))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        }
        
        
    }
    
    final func  leoZoom(tintColor : UIColor = .blue  ,
                        closureDidTapOnCross : (()-> Void )? = nil ) {
        
        if self.image != nil {
            let vc = LeoZoomViewController()
            vc.configure(image: self.image,
                         tintColor: tintColor){
                closureDidTapOnCross?()
                
            }
            UIApplication.leoZoomtopViewController()?.present(vc, animated: true)
           
       
        }

        
    }
  
   
    
}
extension UIApplication {
    class func leoZoomtopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return leoZoomtopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return leoZoomtopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return leoZoomtopViewController(controller: presented)
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





public class LeoZoomButtons : NSObject {
    @objc(THButtonsResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
    private struct Cache {
        
        static var imageOfCross: UIImage?
        static var crossTargets: [AnyObject]?
        
    }
    
    
    
    
    
    
    
    
    @objc dynamic public class var imageOfCross: UIImage {
        if Cache.imageOfCross != nil {
            return Cache.imageOfCross!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 476, height: 476), false, 0)
        LeoZoomButtons.drawCross()
        
        Cache.imageOfCross = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfCross!
    }
    
    
    @objc dynamic public class func drawCross(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 476, height: 476), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 476, height: 476), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 476, y: resizedFrame.height / 476)
        
        
        //// Color Declarations
        let theme = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Group 2
        context.saveGState()
        context.translateBy(x: 238, y: 238)
        context.scaleBy(x: 0.8, y: 0.8)
        
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 167.6, y: -168.4))
        bezierPath.addCurve(to: CGPoint(x: -0.4, y: -238), controlPoint1: CGPoint(x: 122.7, y: -213.3), controlPoint2: CGPoint(x: 63.1, y: -238))
        bezierPath.addCurve(to: CGPoint(x: -168.4, y: -168.4), controlPoint1: CGPoint(x: -63.9, y: -238), controlPoint2: CGPoint(x: -123.5, y: -213.3))
        bezierPath.addCurve(to: CGPoint(x: -238, y: -0.4), controlPoint1: CGPoint(x: -213.3, y: -123.5), controlPoint2: CGPoint(x: -238, y: -63.9))
        bezierPath.addCurve(to: CGPoint(x: -168.4, y: 167.6), controlPoint1: CGPoint(x: -238, y: 63.1), controlPoint2: CGPoint(x: -213.3, y: 122.7))
        bezierPath.addCurve(to: CGPoint(x: -0.4, y: 237.2), controlPoint1: CGPoint(x: -123.5, y: 212.5), controlPoint2: CGPoint(x: -63.9, y: 237.2))
        bezierPath.addCurve(to: CGPoint(x: 167.6, y: 167.6), controlPoint1: CGPoint(x: 63.1, y: 237.2), controlPoint2: CGPoint(x: 122.7, y: 212.5))
        bezierPath.addCurve(to: CGPoint(x: 237.2, y: -0.4), controlPoint1: CGPoint(x: 212.5, y: 122.7), controlPoint2: CGPoint(x: 237.2, y: 63.1))
        bezierPath.addCurve(to: CGPoint(x: 167.6, y: -168.4), controlPoint1: CGPoint(x: 237.2, y: -63.9), controlPoint2: CGPoint(x: 212.5, y: -123.5))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 148.5, y: 148.5))
        bezierPath.addCurve(to: CGPoint(x: -0.4, y: 210.2), controlPoint1: CGPoint(x: 108.7, y: 188.3), controlPoint2: CGPoint(x: 55.8, y: 210.2))
        bezierPath.addCurve(to: CGPoint(x: -149.3, y: 148.5), controlPoint1: CGPoint(x: -56.6, y: 210.2), controlPoint2: CGPoint(x: -109.5, y: 188.3))
        bezierPath.addCurve(to: CGPoint(x: -149.3, y: -149.3), controlPoint1: CGPoint(x: -231.4, y: 66.4), controlPoint2: CGPoint(x: -231.4, y: -67.2))
        bezierPath.addCurve(to: CGPoint(x: -0.4, y: -211), controlPoint1: CGPoint(x: -109.5, y: -189.1), controlPoint2: CGPoint(x: -56.6, y: -211))
        bezierPath.addCurve(to: CGPoint(x: 148.5, y: -149.3), controlPoint1: CGPoint(x: 55.8, y: -211), controlPoint2: CGPoint(x: 108.7, y: -189.1))
        bezierPath.addCurve(to: CGPoint(x: 148.5, y: 148.5), controlPoint1: CGPoint(x: 230.6, y: -67.2), controlPoint2: CGPoint(x: 230.6, y: 66.4))
        bezierPath.close()
        theme.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 104.3, y: -105.1))
        bezier2Path.addCurve(to: CGPoint(x: 85.2, y: -105.1), controlPoint1: CGPoint(x: 99, y: -110.4), controlPoint2: CGPoint(x: 90.5, y: -110.4))
        bezier2Path.addLine(to: CGPoint(x: -0.4, y: -19.5))
        bezier2Path.addLine(to: CGPoint(x: -86, y: -105.1))
        bezier2Path.addCurve(to: CGPoint(x: -105.1, y: -105.1), controlPoint1: CGPoint(x: -91.3, y: -110.4), controlPoint2: CGPoint(x: -99.8, y: -110.4))
        bezier2Path.addCurve(to: CGPoint(x: -105.1, y: -86), controlPoint1: CGPoint(x: -110.4, y: -99.8), controlPoint2: CGPoint(x: -110.4, y: -91.3))
        bezier2Path.addLine(to: CGPoint(x: -19.5, y: -0.4))
        bezier2Path.addLine(to: CGPoint(x: -105.1, y: 85.2))
        bezier2Path.addCurve(to: CGPoint(x: -105.1, y: 104.3), controlPoint1: CGPoint(x: -110.4, y: 90.5), controlPoint2: CGPoint(x: -110.4, y: 99))
        bezier2Path.addCurve(to: CGPoint(x: -95.6, y: 108.3), controlPoint1: CGPoint(x: -102.5, y: 106.9), controlPoint2: CGPoint(x: -99, y: 108.3))
        bezier2Path.addCurve(to: CGPoint(x: -86.1, y: 104.3), controlPoint1: CGPoint(x: -92.2, y: 108.3), controlPoint2: CGPoint(x: -88.7, y: 107))
        bezier2Path.addLine(to: CGPoint(x: -0.5, y: 18.7))
        bezier2Path.addLine(to: CGPoint(x: 85.1, y: 104.3))
        bezier2Path.addCurve(to: CGPoint(x: 94.6, y: 108.3), controlPoint1: CGPoint(x: 87.7, y: 106.9), controlPoint2: CGPoint(x: 91.2, y: 108.3))
        bezier2Path.addCurve(to: CGPoint(x: 104.1, y: 104.3), controlPoint1: CGPoint(x: 98.1, y: 108.3), controlPoint2: CGPoint(x: 101.5, y: 107))
        bezier2Path.addCurve(to: CGPoint(x: 104.1, y: 85.2), controlPoint1: CGPoint(x: 109.4, y: 99), controlPoint2: CGPoint(x: 109.4, y: 90.5))
        bezier2Path.addLine(to: CGPoint(x: 18.7, y: -0.4))
        bezier2Path.addLine(to: CGPoint(x: 104.3, y: -86))
        bezier2Path.addCurve(to: CGPoint(x: 104.3, y: -105.1), controlPoint1: CGPoint(x: 109.6, y: -91.3), controlPoint2: CGPoint(x: 109.6, y: -99.8))
        bezier2Path.close()
        theme.setFill()
        bezier2Path.fill()
        
        
        
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
}

