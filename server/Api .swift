import Foundation

let baseUrl  = "http://localhost:4015/"

extension Api {
    func baseURl() -> String {
        return baseUrl + self.rawValued()
    }
}

enum Api  {
    case login(username : String , password : String )
    case signup(first_name: String ,last_name : String ,age : String ,date: String ,
        username : String ,password : String ,sex : String ,device_type : String ,device_token : String   )
    case update_userInfo(user_id : String , first_name : String , last_name : String , description : String ,   intrest : String    )
    
    case profileImage( user_id: String)
    
    case nilValue ( valueHave : String , someNil : String?
    )
    
    case getME
    func rawValued() -> String {
        switch self {
        case .login:
            return "login"
        case .signup:
            return "signup"
        case .getME:
            return "get"
        case .update_userInfo :
            return "update_userInfo"
        case .nilValue:
            return "dfsw"
        case .profileImage:
            return "profileImage"
            
        }
    }
}

func isSuccess(json : [String : Any] , _ success : Int? = 200) -> Bool{
    
    if let isSucess = json["success"] as? Int {
        if isSucess == success{
            return true
        }
    }
    return false
}
func message(json : [String : Any]) -> String{
    if let message = json["body"] as? String {
        return message
    }
    return ""
}
