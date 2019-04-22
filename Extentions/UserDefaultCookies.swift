//
//  UserDefault.swift
//  Hive
//
//  Created by Nitish Sharma on 13/09/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//

import Foundation

extension NSDictionary {
    var id : Int {
        return self["id"] as!Int
    }
    var email : String {
        return self["email"] as!String
    }
    var username : String {
        
        if let value = self["username"] as? String {
            return value
        }else {
            return ""
        }
        
    }
    var contact : String{
         return self["contact"] as!String
    }
    var location : String{
        return self["location"] as!String
    }
    var key_skills : String{
        return self["key_skills"] as!String
    }
    var linkedin : String{
        return self["linkedin"] as!String
    }
    var image : String{
        return self["profile_image"] as?String ?? "myplan"
    }
  /*
     age = 3213;
     company = 1231;
     "created_at" = "2018-10-27T07:18:20.000Z";
     "device_token" = "device_token557";
     "device_type" = "device_type557";
     dob = 1231;
     email = "fd@d.com";
     firstname = 1231;
     height = 321;
     id = 1;
     lastname = 1231;
     password = e10adc3949ba59abbe56e057f20f883e;
     "profile_image" = "";
     status = 0;
     weight = 1231;
 */
}
class Cookies {
    class func userInfoSave( dict : [String : Any]? = nil){
         UserDefaults.standard.set( dict, forKey: "userInfoSave")
         UserDefaults.standard.synchronize()
    }
    class func userInfo() -> NSDictionary? {
        if let   some =  UserDefaults.standard.object(forKey: "userInfoSave") as? NSDictionary {
            return some
    
        
        }
        return nil
    }
}

var temporyRefferencNumber :String? {
    
    get {
        return  UserDefaults.standard.currentRefference()
    }
    set {
        UserDefaults.standard.currentRefferenceSet(newValue)
    }
    
    
}


extension UserDefaults {
    
    /// Private key for persisting the active Theme in UserDefaults
    private static let CurrentRefference = "currentRefferenceTH"

    /// Retreive theme identifer from UserDefaults
    public func currentRefference() -> String? {
        return self.string(forKey: UserDefaults.CurrentRefference)
    }
    
    /// Save theme identifer to UserDefaults
    public func currentRefferenceSet(_ identifier: String?) {
        self.set(identifier, forKey: UserDefaults.CurrentRefference)
    }
    
}







