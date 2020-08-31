//
//  Theme.swift
//  SomeTheme
//
//  Created by Vijayvir Singh on 04/08/20.
//  Copyright © 2020 Vijayvir Singh. All rights reserved.
//
import UIKit
import Foundation
protocol Theme {
    var primaryColor : UIColor { get}
    var primaryPlaceholderColor : UIColor{ get}
    var name : String {get}
    var backGroundImage : UIImage { get }
    var  foregroundImage: UIImage {get}
}
class StockDarkTheme : Theme , LeoElementable {
    var foregroundImage: UIImage =  UIImage(named: "nearbyfuelpump_home")!
    
    var backGroundImage: UIImage = UIImage(named: "nearbyfuelpump_home")!
    
    
    var name: String = "Dark"
    var primaryPlaceholderColor: UIColor = .white
    let primaryColor: UIColor = .black
    var leoText: String {
           return name
       }
}
class StockLightTheme : Theme , LeoElementable {
    var backGroundImage: UIImage = UIImage(named: "refuel_home")!
        var foregroundImage: UIImage =  UIImage(named: "nearbyfuelpump_home")!
    var name: String = "Light"
    
    var primaryPlaceholderColor: UIColor  = .black
    let primaryColor: UIColor = .white
    var leoText: String {
        return name
    }
}
class GreenTheme : Theme , LeoElementable {

    var backGroundImage: UIImage = UIImage(named:"total_sales_home")!
        var foregroundImage: UIImage =  UIImage(named: "nearbyfuelpump_home")!
    var name: String = "Green"
    var primaryPlaceholderColor: UIColor  = .white
    let primaryColor: UIColor = .green
    var leoText: String {
        return name
    }
}

class RedTheme : Theme , LeoElementable {

    var backGroundImage: UIImage = #imageLiteral(resourceName: "nearbyfuelpump_home")
    var foregroundImage: UIImage =  UIImage(named: "nearbyfuelpump_home")!
    var name: String = "red"
    var primaryPlaceholderColor: UIColor  = .white
    let primaryColor: UIColor = .red
    var leoText: String {
        return name
    }
}

class PurpleTheme : Theme , LeoElementable {

    var backGroundImage: UIImage = #imageLiteral(resourceName: "nearbyfuelpump_home")
    var foregroundImage: UIImage =  UIImage(named: "nearbyfuelpump_home")!
    var name: String = "Puple"
    var primaryPlaceholderColor: UIColor  = .white
    let primaryColor: UIColor = .red
    var leoText: String {
        return name
    }
}


protocol ThemeViemProtocol : class {
    func applyTheme()
}


var currentTheme: Theme = StockDarkTheme()

class ThemeProvider {
    static var currentTheme  : Theme = StockDarkTheme()
}
