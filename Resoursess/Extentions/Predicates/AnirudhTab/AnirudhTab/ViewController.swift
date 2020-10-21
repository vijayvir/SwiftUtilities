//
//  ViewController.swift
//  AnirudhTab
//
//  Created by Vijayvir Singh on 09/10/20.
//


import UIKit
class PlusButtonConfiguration {
    var isHidden = false
    var image : UIImage?
    var title : String = ""
    var notificationID : String = ""
}

class PlusButton : UIButton {
    static let notificationPlusButton : String = "NotificationsPlusButton"
    var configuarator : PlusButtonConfiguration?
    func addObsever(){
        leoAddObsever(PlusButton.notificationPlusButton) { [self] (notifcation) in
            
           print(notifcation)
            if let some = notifcation.object as? PlusButtonConfiguration {
                self.setTitle(some.title, for: .normal)
                print(some.title,"*******************")
                self.configuarator = some
            }
        }
    }
  
}

class ViewController: UIViewController {

    @IBOutlet weak var ThirdButton: PlusButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ThirdButton.addObsever()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var btnTabs: [FATabButton]!
    @IBAction func actionThirdButton(_ sender: Any) {
      print("PlusButtonIs Tab")
        if ThirdButton.configuarator != nil {
            NotificationCenter.default.post(name: Notification.Name(ThirdButton.configuarator!.notificationID), object: nil)
        }
        
    }
    
    @IBAction func actionTab(_ sender: FATabButton) {
        print(sender.identifier, sender.selectedTab)
        for object in btnTabs {
            object.continer.isHidden = true
            if object.identifier == "FourthButton" {
                if object.selectedTab == "3.1" {
                    object.selectedTab = "3.2"
                   
                }else {
                    object.selectedTab = "3.1"
                 
                }
               
            }
        }
        sender.continer.isHidden = false
        
        if sender.identifier == "FirstButton"{
            NotificationCenter.default.post(name: NSNotification.Name( FirstViewController.NotificationHomeTab), object: nil)
        }
        
        if sender.identifier == "FourthButton" {
            NotificationCenter.default.post(name: Notification.Name(ThirdViewController.notificationThirdTab), object: sender.selectedTab )
            if sender.selectedTab == "3.1" {

                sender.setTitle("N", for: .normal)
            }else {
             
                sender.setTitle("R", for: .normal)
            }
        }
    
        
    }
    
}
extension UIViewController {
    func leoAddObsever(_ string: String) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.leoSelector),
            name: Notification.Name(string),
            object: nil)
    }
    @objc private func leoSelector(notification: NSNotification){
        
        
    }
}
 
class FirstViewController : UIViewController {
    static let NotificationHomeTab : String = "NotificationHomeTab"
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.leoPop),
//            name: Notification.Name(FirstViewController.NotificationHomeTab),
//            object: nil)
        leoAddObsever2(FirstViewController.NotificationHomeTab) { (n) in
            self.navigationController?.popToRootViewController(animated: true)
        }
      
        // Do any additional setup after loading the view.
    }
    @objc private func leoPop(notification: NSNotification){
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
       
        super.viewDidAppear(true)
        let sample = PlusButtonConfiguration()
        sample.title = "F"
        sample.notificationID = "DFirsrt"
        NotificationCenter.default.removeObserver(self, name: Notification.Name(sample.notificationID), object: nil)
       
   
        self.leoAddObsever(sample.notificationID) { (notification) in
            print("SFirstButtonoucj")

        }
        
        NotificationCenter.default.post(name: Notification.Name(PlusButton.notificationPlusButton), object: sample)
    }
    
    
}
class SericeViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let sample = PlusButtonConfiguration()
        sample.title = "S"
        sample.notificationID = "STouchCenterButton"
        self.leoAddObsever(sample.notificationID) { (notification) in
            print("STouchCenterButton")
       
        }
        NotificationCenter.default.post(name: Notification.Name(PlusButton.notificationPlusButton), object: sample)
        // Do any additional setup after loading the view.
    }
}


class SecondViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class RefuelViewController  : UIViewController  {
    static let notification = "NotificationRefuel"
    override func viewDidLoad() {
        super.viewDidLoad()
        leoAddObsever(RefuelViewController.notification) { (notifiication) in
            let sample = PlusButtonConfiguration()
            sample.title = "R"
            sample.notificationID = "RTouchCenterButton"
            self.leoAddObsever(sample.notificationID) { (notification) in
                print("RTouchCenterButton")
                NotificationCenter.default.post(name: Notification.Name(PlusButton.notificationPlusButton), object: sample)
            }
            NotificationCenter.default.post(name: Notification.Name(PlusButton.notificationPlusButton), object: sample)
          
        }
        // Do any additional setup after loading the view.
    }
    
    
}
class NearByScreenViewContoller: UIViewController {
    static let notification = "NotificationNearByScreen"
    override func viewDidLoad() {
        super.viewDidLoad()
        leoAddObsever(NearByScreenViewContoller.notification) { (notifiication) in
            
            let sample = PlusButtonConfiguration()
            sample.title = "N"
            sample.notificationID = "NTouchCenterButton"
            self.leoAddObsever(sample.notificationID) { (notification) in
                print("NTouchCenterButton")
                
                NotificationCenter.default.post(name: Notification.Name(PlusButton.notificationPlusButton), object: sample)
            }
            NotificationCenter.default.post(name: Notification.Name(PlusButton.notificationPlusButton), object: sample)
           
        }
        // Do any additional setup after loading the view.
    }
}

class ThirdViewController : UIViewController {
    
    @IBOutlet weak var thirdOne: UIView!
    @IBOutlet weak var thirdTwo: UIView!
    
    static let notificationThirdTab = "notificationThirdTab"
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.tabSelected),
            name: Notification.Name(ThirdViewController.notificationThirdTab),
            object: nil)
        // Do any additional setup after loading the view.
    }
    @objc private func tabSelected(notification: NSNotification){
      
        if let subIdentifer = notification.object as? String{
            print(subIdentifer)
            if subIdentifer == "3.1" {
                thirdOne.isHidden = false
                thirdTwo.isHidden = true
                NotificationCenter.default.post(name: Notification.Name(RefuelViewController.notification), object: RefuelViewController.notification)
            }else if subIdentifer == "3.2" {
                thirdOne.isHidden = true
                thirdTwo.isHidden = false
                NotificationCenter.default.post(name: Notification.Name(NearByScreenViewContoller.notification), object: NearByScreenViewContoller.notification)
            }
        }
        //do stuff using the userInfo property of the notification object
    }
}
