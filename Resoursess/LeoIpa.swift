
import Foundation
/**
 - Author: Vijavir
 */
enum  LeoIpa {
    case live
    case developlement
    case client
    static var status : [LeoIpa]  =  [.client]
    
    static func run(_ value : [LeoIpa] = [.developlement] , run :(()-> Void) ) {
        

        if LeoIpa.status.contains(.developlement) {
       
            run()
            
        }
    }
   static func  addDevlopementMode() {
    
        LeoIpa.status.append(.developlement)
    }
    
    static func  removeDevelopementMode() {
        
        LeoIpa.status.removeAll { ( build) -> Bool in
            return build == .developlement
        }
    }
    
    static var isDevelopment : Bool {
        
        let some = LeoIpa.status.filter { (build) -> Bool in
            if build == .developlement {
                return true
            }
            return false
        }
        
        if some.count > 0 {
               return true
        }
        
        return false
    }
    
    
}
