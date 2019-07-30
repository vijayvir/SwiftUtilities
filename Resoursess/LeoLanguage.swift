//
//  LeoLanguage.swift
//  UGW
//
//  Created by tecH on 25/07/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit

/**
 - Author: Vijavir
 */
extension String {
    func leoLocalized() -> String{
        let localizedTitle = NSLocalizedString(self, comment: "")
        return localizedTitle
        
    }
}



enum  LeoLangStoryboardType : String{
    case Main = "Main"
    case AWS = "AWS"
    case Token = "Token"
}
func storyBoardLeoLang(_ type :  LeoLangStoryboardType? = .Main) -> UIStoryboard? {
    
    if let storyboard = UIStoryboard(name: type!.rawValue, bundle: nil) as? UIStoryboard {
        return storyboard
    }
    
    return nil
}


class LeoLanguage{
    
    var language : String = ""
    var flag : String = ""
    var shotForm :String =  ""
    var code : String =  "en"
    
    init(language : String , flag : String = "" , shotForm :String, code : String) {
        self.code =  code
        self.language =  language
        self.flag =  flag
        self.shotForm = shotForm
    }
    
   
    static var languages : [LeoLanguage]  {
        var languages : [LeoLanguage] = []
        languages.append(LeoLanguage(language: "English-US", flag: "🇺🇸", shotForm: "US", code: "en"))
        languages.append(LeoLanguage(language: "German", flag: "🇩🇪", shotForm: "DE", code: "de"))
        languages.append(LeoLanguage(language: "French", flag: "🇫🇷", shotForm: "FR", code: "fr"))
    
        
        
        return languages
        
    }
    
    class func current(code : String = "en") -> LeoLanguage {
        
        let curr =  LeoLanguage.languages.first(where: { (lang) -> Bool in
            if code == lang.code {
                return  true
            }
            
            return false
        })
        
        return curr ?? LeoLanguage(language: "English-US", flag: "🇺🇸", shotForm: "US", code: "en")
        
    }
    
    @discardableResult
    class func getCurrent() -> String{
        let userdef = UserDefaults.standard
        if let langArray = userdef.object(forKey: "AppleLanguages") as? Array<String> {
            return langArray.first!
        }
      //  let current = langArray.firstObject as! String
        return""
    }
    
    class func set(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,LeoLanguage.getCurrent()], forKey: "AppleLanguages")
        
       
        userdef.synchronize()
    }
    
    
}
extension LeoLanguage : LeoElementable{
    var leoText: String {
        return "\(flag) \(shotForm)"
    }
    
  var leoTextOnPicker : String {
    
    return "\(flag) \(language)"
    
    }
}
extension LeoLanguage {
    
    class func showThat(rootNavIdentifier : String = "rootnav" , storyboard : LeoLangStoryboardType = .Main){
        
        //LeoLanguage.doTheSwizzling()
        let rvc: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rvc.rootViewController =

            storyBoardLeoLang(storyboard)?.instantiateViewController(withIdentifier: rootNavIdentifier)
//
        
        //                UIView.transition(with: mainwindow, duration: 0.55001, options: [], animations: { () -> Void in
        //                }) { (finished) -> Void in
        //                }
        //
        
    }
    
    class func doTheSwizzling() {
        // 1 // didFinishLaunchingWithOptions
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(key:value:table:)))
    }
}
extension Bundle {
    @objc func specialLocalizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        /*2*/let currentLanguage = LeoLanguage.getCurrent()
        var bundle = Bundle();
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path)!
        } else {
            let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
            bundle = Bundle(path: _path)!
        }
        /*4*/return (bundle.specialLocalizedStringForKey(key: key, value: value, table: tableName))
    }
}
/// Exchange the implementation of two methods for the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    if let origMethod: Method = class_getInstanceMethod(cls, originalSelector){
        if let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector){
            
            if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
                class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
            } else {
                method_exchangeImplementations(origMethod, overrideMethod);
            }
            
        }
        
    }
   
  
}
/*  txtLanguage.configure(withElements: LeoLanguage.languages)
 
 txtLanguage.closureDidCancel = {
 self.txtLanguage.text = LeoLanguage.current(code: LeoLanguage.getCurrent()).leoText
 
 }
 
 txtLanguage.closureDidSelectElement = { element , by in
 
 if by == .doneButtonTap {
 
 if let lang = element as? LeoLanguage {
 
 LeoLanguage.set(lang: lang.code)
 
 LeoLanguage.showThat()
 //
 //                let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
 //                rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "rootnav")
 //
 
 //                UIView.transition(with: mainwindow, duration: 0.55001, options: [], animations: { () -> Void in
 //                }) { (finished) -> Void in
 //                }
 //
 
 
 }
 
 }
 
 }
 txtLanguage.text = LeoLanguage.current(code: LeoLanguage.getCurrent()).leoText
 
 
 */
