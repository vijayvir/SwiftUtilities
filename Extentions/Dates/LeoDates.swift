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

/*
 
 Year:
 YYYY (eg 1997)
 Year and month:
 YYYY-MM (eg 1997-07)
 Complete date:
 YYYY-MM-DD (eg 1997-07-16)
 Complete date plus hours and minutes:
 YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20+01:00)
 Complete date plus hours, minutes and seconds:
 YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30+01:00)
 Complete date plus hours, minutes, seconds and a decimal fraction of a
 second
 YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+01:00)
 where:
 
 YYYY = four-digit year
 MM   = two-digit month (01=January, etc.)
 dd   = two-digit day of month (01 through 31)
 DD   =  Days from the start of year
 
 hh   = two digits of hour (00 through 23) (am/pm NOT allowed)
 mm   = two digits of minute (00 through 59)
 ss   = two digits of second (00 through 59)
 s    = one or more digits representing a decimal fraction of a second
 TZD  = time zone designator (Z or +hh:mm or -hh:mm)
 */

import Foundation

class  LeoDates {
    var suggestedFormates : [String] =  ["yyyy-MM-dd hh:mm:ss" ,
                                         "dd-MM-yyyy hh:mm:ss" ,
                                         "yyyy-MM-dd" , "yyyy-MM-dd'T'HH:mm:ssZ"]
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
extension  LeoDates {
    enum Format {
        
        case mmDDYYYYYhhmma
        
        case yyyyMMddHHmmSSZ
        
        case yyyyMMddHHmmSS
        // "2017-11-08 10:18:03"
        
        case hhmma
        
        case mmDDYYYYY
        
        case ddMMYYYYYhhmma
        
        case yyyyMMdd
        
        var name: String {
            
            switch self {
                
            case .mmDDYYYYYhhmma: return "MM-dd-yyyy hh:mm a"
            case .yyyyMMddHHmmSS: return "yyyy-MM-dd HH:mm:ss "
                
                // "2017-11-08 10:18:03"
                
            case .mmDDYYYYY: return "MM-dd-yyyy"
                
            case .yyyyMMdd : return "yyyy-MM-dd"
                
            case .ddMMYYYYYhhmma: return "dd-MM-yyyy hh:mm a"
                
            case .yyyyMMddHHmmSSZ: return "yyyy-MM-dd HH:mm:ss Z"
                
                // "2019-03-30T06:21:28.000Z  ->   "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                
            // case . yyyy-MM-dd'T'HH:mm:ssZ return "yyyy-MM-dd'T'HH:mm:ssZ"
            case .hhmma: return "hh:mm a"
            }
        }
    }
}

extension Date {
    
    func dayDifference( format : String? = LeoDates.Format.yyyyMMddHHmmSSZ.name , to : String? = LeoDates.Format.mmDDYYYYY.name ) -> String {
        
        let calendar = NSCalendar.current
        
        if calendar.isDateInYesterday(self) { return "Yesterday" }
            
        else if calendar.isDateInToday(self) { return "Today" }
            
        else if calendar.isDateInTomorrow(self) { return "Tomorrow" }
            
        else {
            
            return    "\(self)".dateToDate(from: format!, to: to!)
            
        }
    }
    
    func smartFormat(fromDate : Date? = Date()) -> String {
        
        
        return self.timeIntervalSinceNow.smartFormat()
    }
}

extension Double {
    
    private func secondsToHoursMinutesSeconds () -> (Int?, Int?, Int?) {
        
        let hrs = self / 3600
        
        let mins = (self.truncatingRemainder(dividingBy: 3600)) / 60
        
        let seconds = (self.truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60)
        
        return (Int(hrs) > 0 ? Int(hrs) : nil, Int(mins) > 0 ? Int(mins) : nil, Int(seconds) > 0 ? Int(seconds) : nil)
    }
    
    func smartFormat () -> String {
        
        let time = self.secondsToHoursMinutesSeconds()
        
        switch time {
            
        case (nil, let x?, let y?):
            
            return "\(x) min \(y) sec"
            
        case (nil, let x?, nil):
            
            return "\(x) min"
            
        case (let x?, nil, nil):
            
            return "\(x) hr"
            
        case (nil, nil, let x?):
            
            return "\(x) sec"
            
        case (let x?, nil, let z?):
            
            return "\(x) hr \(z) sec"
            
        case (let x?, let y?, nil):
            
            return "\(x) hr \(y) min"
            
        case (let x?, let y?, let z?):
            
            return "\(x) hr \(y) min \(z) sec"
            
        default:
            
            return "\(self)"
        }
    }
}

extension String {
    
    func dateToDate(from: String, to: String) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = from
        
        dateFormatter.timeZone = NSTimeZone.local
        
        guard let date = dateFormatter.date(from: self) else {
            
            assert(false, "no date from string")
            
            return ""
            
        }
        dateFormatter.dateFormat = to
        
        dateFormatter.timeZone = NSTimeZone.local
        
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    func date(format: String) -> Date? {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        formatter.timeZone = NSTimeZone.local
        
        return formatter .date(from: self)
    }
    
    func stringtoDate(format: String) -> Date? {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        formatter.timeZone = NSTimeZone.local
        
        return formatter .date(from: self)
    }
    
    
}
extension NSDate {
    
    func getElapsedInterval() -> String {
        
        var interval = NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
        
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "year" :
                "\(interval)" + " " + "years"
        }
        
        interval = NSCalendar.currentCalendar().components(.Month, fromDate: self, toDate: NSDate(), options: []).month
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "month" :
                "\(interval)" + " " + "months"
        }
        
        interval = NSCalendar.currentCalendar().components(.Day, fromDate: self, toDate: NSDate(), options: []).day
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "day" :
                "\(interval)" + " " + "days"
        }
        
        interval = NSCalendar.currentCalendar().components(.Hour, fromDate: self, toDate: NSDate(), options: []).hour
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "hour" :
                "\(interval)" + " " + "hours"
        }
        
        interval = NSCalendar.currentCalendar().components(.Minute, fromDate: self, toDate: NSDate(), options: []).minute
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "minute" :
                "\(interval)" + " " + "minutes"
        }
        
        return "a moment ago"
    }
}
