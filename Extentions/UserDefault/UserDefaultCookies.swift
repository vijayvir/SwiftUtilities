import Foundation

extension NSDictionary {
    var user_nr : Int {
        return self["user_nr"] as!Int
    }
    var first_name : String{
        return self["first_name"] as!String
    }
    var last_name : String{
        return self["last_name"] as!String
    }
    var user_id : String{
        return self["user_id"] as!String
    }
    
    /*
     "first_name" = ios;
     "last_name" = app;
     "user_id" = "ios.app";
     "user_nr" = 30137;
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

var currentAccessToken :String? {
    
    get {
        return  UserDefaults.standard.currentAccessToken()
    }
    set {
        UserDefaults.standard.currentAccessToken(newValue)
    }
    
    
}




extension UserDefaults {
    
    /// Private key for persisting the active Theme in UserDefaults
    private static let currentAccessTokenKey = "api.iamgds.com/ota/Auth"
    
    /// Retreive theme identifer from UserDefaults
    public func currentAccessToken() -> String? {
        return self.string(forKey: UserDefaults.currentAccessTokenKey)
    }
    
    /// Save theme identifer to UserDefaults
    public func currentAccessToken(_ identifier: String?) {
        self.set(identifier, forKey: UserDefaults.currentAccessTokenKey)
    }
    
}


extension UserDefaults {
    
    /// Private key for persisting the active Theme in UserDefaults
    private static let currentOffsetContactlistKey = "api.currentOffsetContactlistKey.u"
    
    /// Retreive theme identifer from UserDefaults
    public var currentOffsetContactlist : Int? {
        return self.integer(forKey: UserDefaults.currentOffsetContactlistKey)
    }
    
    /// Save theme identifer to UserDefaults
    public func currentOffsetContactlist(_ identifier: Int?) {
        self.set(identifier, forKey: UserDefaults.currentOffsetContactlistKey)
    }
    
}

extension UserDefaults {
    
    /// Private key for persisting the active Theme in UserDefaults
    private static let currentOffsetContactinfoKey = "api.currentOffsetContactinfoKey.u"
    
    /// Retreive theme identifer from UserDefaults
    public var currentOffsetContactinfo : Int? {
        return self.integer(forKey: UserDefaults.currentOffsetContactinfoKey)
    }
    
    /// Save theme identifer to UserDefaults
    public func currentOffsetContactinfo(_ identifier: Int?) {
        self.set(identifier, forKey: UserDefaults.currentOffsetContactinfoKey)
    }
    
}



extension UserDefaults {
    
    func leoRunOnce( id : String ,_ callBack : (()->Void)? = nil  )  ,_ callBack : (()->Void)? = nil  ) {
        
        if  UserDefaults.standard.bool(forKey:id) == false {
            UserDefaults.standard.set(true, forKey: id)
            callBack?()
        }
        
    }
    
}
