//
//  LeoDates.swift
//  HelloDamage
//
//  Created by tecH on 14/02/19.
//  Copyright © 2019 Ravinder Kumar. All rights reserved.
//

/*
    How To use?
   There are some steps which are written below .
    • Add More dates format when you incounter in your code .
      LeoDates.share.addFormat("yyyy-MM-dd")
       LeoDates.share.addFormat("yyyy-MM-dd")
        // From String  to Date or String
        // Make sure your date format  is added to LeoDates.Share with above code
        let stringDate = "2019-09-08"
        print(stringDate.leoDateString(toFormat: "dd-MMMM-YYYY hh:mm a"))
         // #From Date to Date or String
 
        let  someDate = Date()
        print(someDate.leoDateString(toFormat: "dd-MMMM-yyyy hh:mm:ss"))
 */
import Foundation

class  LeoDates {
    var suggestedFormates : [String] =  ["yyyy-MM-dd hh:mm:ss" ,
                                         "dd-MM-yyyy hh:mm:ss" ,
                                         "yyyy-MM-dd"]
    static let share = LeoDates()
    func addFormat(_ format :String) {
        LeoDates.share.suggestedFormates.append(format)
    }
}

extension String {
    
    func leoDate(toFormat : String? = nil  ) -> Date {
        for object in LeoDates.share.suggestedFormates {
            let formatter1 = DateFormatter()
            formatter1.timeZone = TimeZone(abbreviation: "UTC")
            formatter1.dateFormat = object
            if let dd1StartDate = formatter1.date(from: self){
                if toFormat == nil {
                    return dd1StartDate

                } else {
                    formatter1.dateFormat = toFormat
                    let some = formatter1.string(from: dd1StartDate)
                    formatter1.dateFormat = toFormat
                    return formatter1.date(from: some)!
                }
            }
        }
        print("#warning : Not a proper Date")
        return Date()
    }
    func leoDateString(toFormat : String? = nil  ) -> String {
        for object in LeoDates.share.suggestedFormates {
            let formatter1 = DateFormatter()
            formatter1.timeZone = TimeZone(abbreviation: "UTC")
            formatter1.dateFormat = object
            
            if let dd1StartDate = formatter1.date(from: self){
                
                if toFormat == nil {
                    return "\(dd1StartDate)"
                } else {
                    
                    formatter1.dateFormat = toFormat
                    
                    let some = formatter1.string(from: dd1StartDate)
                    
                    
                    return some
                }
            }
        }
        print("#warning : Not a proper Date")
        return "\(Date())"
    }
}
extension Date {
    
    func leoDate(toFormat : String? = nil  ) -> Date {
        if toFormat == nil {
            return self
        }
        let formatter1 = DateFormatter()
        
        formatter1.timeZone = TimeZone(abbreviation: "UTC")
        
        formatter1.dateFormat = toFormat
        
        let some = formatter1.string(from: self)
        
        formatter1.dateFormat = toFormat
       if let dd1StartDate = formatter1.date(from: some){
        return dd1StartDate
        }
        print("#warning : Not a proper Date")
        return self
    }
    func leoDateString(toFormat : String? = nil  ) -> String {
        if toFormat == nil {
            return "\(self)"
        }
        
        let formatter1 = DateFormatter()
        formatter1.timeZone = TimeZone(abbreviation: "UTC")
        formatter1.dateFormat = toFormat
        let some = formatter1.string(from: self)
         return some
    }
}


