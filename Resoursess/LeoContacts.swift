//
//  LeoContacts.swift
//  iSpy
//
//  Created by tecH on 15/03/19.
//  Copyright © 2019 tecH. All rights reserved.
//

/*
 <key>NSContactsUsageDescription</key>
 <string>$(PRODUCT_NAME) contact use</string>
 */

import Foundation

import Contacts

import UIKit

class LeoContacts {
    enum Keys : Int {
        case fullName = 1
        case phoneNumber = 2
        case email = 3
        case any = 4
        case all
        
    }
    
    static var share = LeoContacts()
    fileprivate var mustKeys :[Keys] = [.any]
    fileprivate var searchOn :[Keys] = [.any]
    fileprivate var contactStore = CNContactStore()
    fileprivate var contactsOriginals = [CNContact]()
    
    fileprivate var searchText : String = ""
    func withMustKeys(_ keys : [Keys] ) -> LeoContacts {
        self.mustKeys = keys
        return self
    }
    
    func withSearchOn(_ keys : [Keys] ) -> LeoContacts {
        self.searchOn = keys
        return self
    }
    func run(_ callback : (() -> ())? = nil ) {
        callback?()
    }
    
    func searchText(_ searchText: String ){
        self.searchText = searchText
    }

    func requestForAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
            
        case .authorized:
            
            completionHandler(true)
            
        case .denied, .notDetermined:
            
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (access, accessError) -> Void in
                
                if access {
                    
                    completionHandler(access)
                    
                }
                else {
                    
                    if authorizationStatus == CNAuthorizationStatus.denied {
                        
                        DispatchQueue.main.async {
                            
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            
                            self.showMessage(message: message)
                        }
                    }
                }
            })
            
        default:
            completionHandler(false)
        }
    }
    func getContacts() -> LeoContacts{
        
        
        
        //CNContactIdentifierKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey, CNContactPhoneNumbersKey, CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName)])
        
        let keys : [CNKeyDescriptor] = [CNContactFormatter.descriptorForRequiredKeys(for: CNContactFormatterStyle.fullName),
                                        CNContactEmailAddressesKey as CNKeyDescriptor,
                                        CNContactPhoneNumbersKey as CNKeyDescriptor,
                                        CNContactImageDataKey as CNKeyDescriptor ]
        do {
            let contactStore = self.contactStore
            try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keys)) { (contact, pointer) -> Void in
                self.contactsOriginals.append(contact)
            }
        }
        catch let error as NSError {
            print(error.description, separator: "", terminator: "\n")
        }
        
        return self
    }
    
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    func showMessage(message: String) {
        
        let appNameUIPhotosButton = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        
        let alertController = UIAlertController(title: appNameUIPhotosButton, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        
        alertController.addAction(dismissAction)
        
        let pushedViewControllers = (LeoContacts.getAppDelegate().window?.rootViewController as! UINavigationController).viewControllers
        let presentedViewController = pushedViewControllers[pushedViewControllers.count - 1]
        
        presentedViewController.present(alertController, animated: true, completion: nil)
    }
}

extension LeoContacts {
    var  contacts : [LeoContactable] {
        get {
            if searchOn.elementsEqual([.fullName]) {
                return contactsBefore.filter({ (contact) -> Bool in
                    
                    if searchText == "" {
                        return true
                    }
                    
                    if contact.leoFullName != nil {
                        if contact.leoFullName!.lowercased().contains( searchText.lowercased()) {
                            return true
                        }
                    }
                    
                    
                    return false
                })
            }  else if searchOn.elementsEqual([.phoneNumber]) {
                return contactsBefore.filter({ (contact) -> Bool in
                    
                    if searchText == "" {
                        return true
                    }
                    
                    if contact.leoPhoneNumber != nil {
                        if contact.leoPhoneNumber!.lowercased().contains( searchText.lowercased()) {
                            return true
                        }
                    }
                    
                    
                    return false
                })
            } else if searchOn.elementsEqual([.email]) {
                return contactsBefore.filter({ (contact) -> Bool in
                    
                    if searchText == "" {
                        return true
                    }
                    
                    if contact.leoEmail != nil {
                        if contact.leoEmail!.lowercased().contains( searchText.lowercased()) {
                            return true
                        }
                    }
                    
                    
                    return false
                })
            }else if searchOn.sorted(by: { (key1, key2) -> Bool in
                return key1.rawValue < key2.rawValue
                
            }).elementsEqual([.fullName, .email]) {
                
                return contactsBefore.filter({ (contact) -> Bool in
                    
                    if searchText == "" {
                        return true
                    }
                    
                    if contact.leoEmail != nil &&  contact.leoFullName != nil   {
                        if contact.leoEmail!.lowercased().contains( searchText.lowercased()) ||  contact.leoFullName!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    } else if contact.leoEmail != nil   {
                        if contact.leoEmail!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    } else if  contact.leoFullName != nil   {
                        if  contact.leoFullName!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    }
                    
                    
                    return false
                })
                
            }else if searchOn.sorted(by: { (key1, key2) -> Bool in
                return key1.rawValue < key2.rawValue
                
            }).elementsEqual([.fullName, .phoneNumber]) {
                
                return contactsBefore.filter({ (contact) -> Bool in
                    
                    if searchText == "" {
                        return true
                    }
                    
                    if contact.leoPhoneNumber != nil &&  contact.leoFullName != nil   {
                        if contact.leoPhoneNumber!.lowercased().contains( searchText.lowercased()) ||  contact.leoFullName!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    } else if contact.leoPhoneNumber != nil   {
                        if contact.leoPhoneNumber!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    } else if  contact.leoFullName != nil   {
                        if  contact.leoFullName!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    }
                    
                    
                    return false
                })
                
            }else if searchOn.sorted(by: { (key1, key2) -> Bool in
                return key1.rawValue < key2.rawValue
                
            }).elementsEqual([.fullName, .phoneNumber ,.email]) ||   searchOn.elementsEqual([.all]) ||   searchOn.elementsEqual([.any]) {
                
                return contactsBefore.filter({ (contact) -> Bool in
                    
                    if searchText == "" {
                        return true
                    }
                    
                    if contact.leoPhoneNumber != nil &&  contact.leoFullName != nil && contact.leoEmail != nil   {
                        if contact.leoPhoneNumber!.lowercased().contains( searchText.lowercased()) ||  contact.leoFullName!.lowercased().contains( searchText.lowercased()) ||  contact.leoEmail!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    } else if contact.leoPhoneNumber != nil   {
                        if contact.leoPhoneNumber!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    } else if  contact.leoFullName != nil   {
                        if  contact.leoFullName!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    }else if  contact.leoEmail != nil   {
                        if  contact.leoEmail!.lowercased().contains( searchText.lowercased())   {
                            return true
                        }
                    }
                    
                    
                    
                    return false
                })
                
            }else {
                return []
            }
        }
    }
    
    fileprivate var contactsBefore : [LeoContactable] {
        get {
            if mustKeys.elementsEqual([.any]) {
                return contactsOriginals
            }else if mustKeys.elementsEqual([.fullName]) {
                
                return contactsOriginals.filter({ (contact) -> Bool in
                    if contact.leoFullName.count > 0 {
                        return true
                    }
                    return false
                })
                
            }else if mustKeys.elementsEqual([.email])  {
                
                return contactsOriginals.filter({ (contact) -> Bool in
                    if contact.leoEmail.count > 0 {
                        return true
                    }
                    return false
                })
                
            }else if mustKeys.elementsEqual([.phoneNumber]){
                
                return contactsOriginals.filter({ (contact) -> Bool in
                    if contact.leoPhoneNumber.count > 0 {
                        return true
                    }
                    return false
                })
                
            }else if mustKeys.sorted(by: { (key1, key2) -> Bool in
                return key1.rawValue < key2.rawValue
                
            }).elementsEqual([.fullName, .email]) {
                
                return contactsOriginals.filter({ (contact) -> Bool in
                    if contact.leoFullName.count > 0  &&   contact.leoEmail.count > 0  {
                        return true
                    }
                    return false
                })
                
            }else if mustKeys.sorted(by: { (key1, key2) -> Bool in
                return key1.rawValue < key2.rawValue
                
            }).elementsEqual([.fullName, .phoneNumber]) {
                
                return contactsOriginals.filter({ (contact) -> Bool in
                    if contact.leoFullName.count > 0  &&   contact.leoPhoneNumber.count > 0  {
                        return true
                    }
                    return false
                })
                
            }else if mustKeys.sorted(by: { (key1, key2) -> Bool in
                return key1.rawValue < key2.rawValue
                
            }).elementsEqual([.fullName, .phoneNumber , .email]) {
                
                return contactsOriginals.filter({ (contact) -> Bool in
                    if contact.leoFullName.count > 0  &&   contact.leoPhoneNumber.count > 0  &&   contact.leoEmail.count > 0  {
                        return true
                    }
                    return false
                })
                
            }else if mustKeys.sorted(by: { (key1, key2) -> Bool in
                return key1.rawValue < key2.rawValue
                
            }).elementsEqual([.all]) {
                
                return contactsOriginals.filter({ (contact) -> Bool in
                    if contact.leoFullName.count > 0  &&   contact.leoPhoneNumber.count > 0  &&   contact.leoEmail.count > 0  {
                        return true
                    }
                    return false
                })
                
            }
            return []
        }
    }
}

@objc protocol LeoContactable  {
    @objc optional var leoFullName : String {get}
    @objc optional var leoPhoneticFullName : String {get}
    @objc optional var leoPhoneNumber : String {get}
    @objc optional var leoEmail : String {get}
    @objc optional var leoImage : UIImage? {get}
    @objc optional var leoIdentifier : String {get}
    
}

extension CNContact : LeoContactable  {
    
    var leoFullName : String {
        if let some = CNContactFormatter.string(from: self, style: .fullName)  {
            return some
        }
        return ""
    }
    
    var leoPhoneticFullName : String {
        if let some = CNContactFormatter.string(from: self, style: .phoneticFullName)  {
            return some
        }
        return ""
    }
    
    var leoPhoneNumber : String {
        if self.phoneNumbers.count > 0 {
            if let some = (self.phoneNumbers[0].value ).value(forKey: "digits") as? String  {
                return some
            }
        }
        return ""
    }
    
    var leoEmail : String {
        for emailAddress in self.emailAddresses {
            if emailAddress.label == CNLabelHome {
                return emailAddress.value as String
            }else if emailAddress.label == CNLabelWork {
                return emailAddress.value as String
            }
        }
        return ""
    }
    var leoImage : UIImage? {
        if self.isKeyAvailable(CNContactImageDataKey)  {
            // there is an image for this contact
            if let data = self.imageData  {
                return UIImage(data: data)
            }
            // Do what ever you want with the contact image below
            
        }
        return nil
    }
    
    
    var leoIdentifier : String {
     
        return self.identifier
    }
    
}
