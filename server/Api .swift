import Foundation

let baseUrl  = "http://localhost:8080/"

extension Api {
    func baseURl() -> String {
        return baseUrl + self.rawValued()
    }
}
enum Api{
    case userSignup
    case userLogin
    case userReferenceSearch
    case userAddReferenceNumber
    case addSurveyDetails
    
    case none
    func rawValued() -> String {
        switch self {
            
        case .userLogin:
            return "userLogin"
            
        case .userSignup:
            return "userSignup"
            
        case .userReferenceSearch:
            return "userReferenceSearch"
            
        case .userAddReferenceNumber:
            return "userAddReferenceNumber"
            
        case .addSurveyDetails :
            return "addSurveyDetails"
            
        default:
            return "user_registration"
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
