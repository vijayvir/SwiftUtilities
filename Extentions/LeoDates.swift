//
//  LeoDates.swift
//  TransportStatus
//
//  Created by vijay vir on 5/17/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import Foundation

enum LeoDates {
    
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


extension Date {
    
    
    func dayDifference( format : LeoDates? = LeoDates.yyyyMMddHHmmSSZ , to : LeoDates? = LeoDates.mmDDYYYYY ) -> String {
        
        let calendar = NSCalendar.current
        
        if calendar.isDateInYesterday(self) { return "Yesterday" }
            
        else if calendar.isDateInToday(self) { return "Today" }
            
        else if calendar.isDateInTomorrow(self) { return "Tomorrow" }
            
        else {
            
            return    "\(self)".dateToDate(from: format!.name, to: (to?.name)!)
            
        }
    }
}

extension Double {
    
    private func secondsToHoursMinutesSeconds () -> (Int?, Int?, Int?) {
        
        let hrs = self / 3600
        
        let mins = (self.truncatingRemainder(dividingBy: 3600)) / 60
        
        let seconds = (self.truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60)
        
        return (Int(hrs) > 0 ? Int(hrs) : nil, Int(mins) > 0 ? Int(mins) : nil, Int(seconds) > 0 ? Int(seconds) : nil)
    }
    
    func hoursMinutesSeconds () -> String {
        
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
            
            return "n/a"
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
