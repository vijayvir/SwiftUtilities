//
//  LeoSwiftTableGenetator.swift
//
//  Created by tecH on 11/02/19.
//  Copyright © 2019 Vijayvir Singh . All rights reserved.
//

import Foundation
import UIKit

/*
 let builder = LeoSwiftTableGenerator.Builder()
 .withCellName("BusPassengerInfo")
 .withObject("SeatButton")
 .withLabels(["seatNo" ])
 .withImages(["user" , "cancel", "useR"])
 .withTextFields(["name","age" , "gender"])
 .withArrayName("pass_Seats", className: "BusPassengersInfoViewController")
 .build()
 */
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}


extension StringProtocol {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
    
    var unCapitalized: String {
        guard let first = first else { return "" }
        return String(first).lowercased() + dropFirst()
    }
}


class LeoSwiftTableGenerator {
    
    var cellName : String  = "SomeCell"
    var arrayName : String?
    var className : String?
    
    var key : String?
    var labels : [String] = []
    var images : [String] = []
    var actions : [String] = []
    var textFields : [String] = []
    
    

    class Builder {
           var type : TypeLeo =  .table
        enum TypeLeo {
            case table
            case collectionTable
            
        }

        
        init(_ typee : TypeLeo? = .table){
            
            self.type = typee ?? .table
        }
        
        private let code = LeoSwiftTableGenerator()
        
        func withCellName(_ name: String) -> Self {
            code.cellName = name
            return self
        }
        
        
        func withArrayName(_ name: String , className : String) -> Self {
            code.arrayName = name
            code.className = className
            return self
        }
        
        
        func withObject(_ key: String) -> Self {
            code.key = key
            return self
        }
        
        func withLabels(_ label: [String]) -> Self {
            code.labels = label
            return self
        }
        
        
        func withActions(_ actions: [String]) -> Self {
            code.actions = actions
            return self
        }
        
        func withTextFields(_ textFields: [String]) -> Self {
            code.textFields = textFields
            return self
        }
        
        func withImages(_ images: [String]) -> Self {
            code.images = images
            return self
        }
        
        
       private func tableBuilder() {
            
            print("import UIKit")
            
            if code.images.count > 0 {
                print("import Nuke")
            }
            
            
            if code.arrayName != nil {
                let ssome =  """
                extension \(code.className.leoSafe(defaultValue: "SomeClass")) : UITableViewDelegate,UITableViewDataSource{
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return \(code.arrayName!.unCapitalized).count
                }
                func numberOfSections(in tableView: UITableView) -> Int {
                return 1
                }
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(code.cellName.firstCapitalized)TableViewCell") as! \(code.cellName.firstCapitalized)TableViewCell
                
                """
                print(ssome)
                
                if code.key != nil {
                    
                    print("if let some = \(code.arrayName!.unCapitalized)[indexPath.row] as?  \(code.key!.firstCapitalized) {")
                    print(" cell.configure(\(code.key!.unCapitalized) :  some)")
                    print(" cell.callBackTap = { object in ")
                    print("  }")
                    
                    for labelKey in code.actions.unique() {
                        
                        print(" cell.callBackTap\(labelKey.firstCapitalized) = { object in ")
                        print("  }")
                        
                        
                    }
                    
                    print("  }")
                } else {
                for labelKey in code.actions.unique() {
                
                    print(" cell.callBackTap\(labelKey.firstCapitalized) = {  ")
                    print("  }")
                    
                    
                    }
                }
                
                print(" return cell")
                
                print("}")
                print("}")
            }
            
            
            print("class \(code.cellName.firstCapitalized)TableViewCell : UITableViewCell {")
            
            print("\n")
            
            for imageKey in code.images.unique() {
                
                print("@IBOutlet weak var imgv\(imageKey.firstCapitalized): UIImageView?")
                
            }
            print("\n")
            for labelKey in code.labels.unique() {
                print("@IBOutlet weak var lbl\(labelKey.firstCapitalized): UILabel?")
            }
        
        print("\n")
        for labelKey in code.textFields.unique() {
            print("@IBOutlet weak var txt\(labelKey.firstCapitalized): UITextField?")
        }
        
        
            for labelKey in code.actions.unique() {
                
                if code.key != nil {
                    print("var callBackTap\(labelKey.firstCapitalized) : ((KeyOb) -> Void)?")
                } else {
                    print("var callBackTap\(labelKey.firstCapitalized) : (() -> Void)?")
                }

            }
            
            
            
            
            
            print("\n")
            if code.key != nil {
                print(" var \(code.key!.unCapitalized) : \(code.key!.firstCapitalized)?")
                print("var callBackTap : ((\(code.key!.firstCapitalized)) -> Void)?" )
                print("\n")
                
            }
            // configure Functiion
            if code.key != nil {
                print("func configure(\(code.key!.unCapitalized) : \(code.key!.firstCapitalized) ) {")
                
                print("self.\(code.key!.unCapitalized) = \(code.key!.unCapitalized)")
                print("\n")
                
                for labelKey in code.labels.unique() {
                    print("//lbl\(labelKey.firstCapitalized)?.text = \(code.key!.unCapitalized).\(labelKey.unCapitalized)")
                    
                }
                print("\n")
                for imageKey in code.images.unique() {
                    
                    print("// if  let url = URL(string: \(code.key!.unCapitalized).\(imageKey.unCapitalized).leoSafe()) {")
                    print("// if imgv\(imageKey.firstCapitalized) != nil {")
                    print("// Nuke.loadImage(with: url, into: imgv\(imageKey.firstCapitalized)!)")
                    print("// }")
                    print("//}")
                    print("\n")
                    
                }
                print("}")
                // actionTap
                print("@IBAction func actionTap(_ UIButton: Any) {")
                print("if self.\(code.key!.unCapitalized)  != nil {" )
                print("callBackTap?(self.\(code.key!.unCapitalized)!)" )
                print("}" )
                print("}" )
                
          
                
                
                
            }
            for labelKey in code.actions.unique() {
                
                if code.key != nil {
                    print("@IBAction func actionTap\(labelKey.firstCapitalized)(_ UIButton: Any) {")
                    print("if self.\(code.key!.unCapitalized)  != nil {" )
                    print("callBackTap\(labelKey.firstCapitalized)?(self.\(code.key!.unCapitalized)!)" )
                    print("}" )
                    print("}" )
                    
                } else {
                    print("@IBAction func actionTap\(labelKey.firstCapitalized)(_ UIButton: Any) {")
                    print("callBackTap\(labelKey.firstCapitalized)?()" )
                    print("}" )
                }
                
            }
            
            print("}")
            
            print("")
            
        }
       private func  collectionBuilder() {
            
            print("import UIKit")
            
            if code.images.count > 0 {
                print("import Nuke")
            }
            
            
            if code.arrayName != nil {
                let ssome =  """
                extension \(code.className.leoSafe(defaultValue: "SomeClass")) : UICollectionViewDelegate,UICollectionViewDataSource{
                func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return \(code.arrayName!.unCapitalized).count
                }
                func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
                }
                func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(code.cellName.firstCapitalized)CollectionView", for: indexPath) as! \(code.cellName.firstCapitalized)CollectionView
                
                
                """
                print(ssome)
                
                if code.key != nil {
                    
                    print("if let some = \(code.arrayName!.unCapitalized)[indexPath.row] as?  \(code.key!.firstCapitalized) {")
                    print(" cell.configure(\(code.key!.unCapitalized) :  some)")
                    print(" cell.callBackTap = { object in ")
                    print("  }")
                    
                    for labelKey in code.actions.unique() {
                        
                        print(" cell.callBackTap\(labelKey.firstCapitalized) = { object in ")
                        print("  }")
                        
                        
                    }
                    
                    print("  }")
                } else {
                    for labelKey in code.actions.unique() {
                        
                        print(" cell.callBackTap\(labelKey.firstCapitalized) = {  ")
                        print("  }")
                        
                        
                    }
                }
                
                print(" return cell")
                
                print("}")
                print("}")
            }
            
            
            print("class \(code.cellName.firstCapitalized)CollectionView : UICollectionViewCell {")
            
            print("\n")
            
            for imageKey in code.images.unique() {
                
                print("@IBOutlet weak var imgv\(imageKey.firstCapitalized): UIImageView?")
                
            }
            print("\n")
            for labelKey in code.labels.unique() {
                print("@IBOutlet weak var lbl\(labelKey.firstCapitalized): UILabel?")
            }
            for labelKey in code.actions.unique() {
                
                if code.key != nil {
                    print("var callBackTap\(labelKey.firstCapitalized) : ((KeyOb) -> Void)?")
                } else {
                    print("var callBackTap\(labelKey.firstCapitalized) : (() -> Void)?")
                }
                
            }
        
            print("\n")
            if code.key != nil {
                print(" var \(code.key!.unCapitalized) : \(code.key!.firstCapitalized)?")
                print("var callBackTap : ((\(code.key!.firstCapitalized)) -> Void)?" )
                print("\n")
            }
            // configure Functiion
            if code.key != nil {
                print("func configure(\(code.key!.unCapitalized) : \(code.key!.firstCapitalized) ) {")
                
                print("self.\(code.key!.unCapitalized) = \(code.key!.unCapitalized)")
                print("\n")
                
                for labelKey in code.labels.unique() {
                    print("//lbl\(labelKey.firstCapitalized)?.text = \(code.key!.unCapitalized).\(labelKey.unCapitalized)")
                    
                }
                print("\n")
                for imageKey in code.images.unique() {
                    
                    print("// if  let url = URL(string: \(code.key!.unCapitalized).\(imageKey.unCapitalized).leoSafe()) {")
                    print("// if imgv\(imageKey.firstCapitalized) != nil {")
                    print("// Nuke.loadImage(with: url, into: imgv\(imageKey.firstCapitalized)!)")
                    print("// }")
                    print("//}")
                    print("\n")
                    
                }
                print("}")
                // actionTap
                print("@IBAction func actionTap(_ UIButton: Any) {")
                print("if self.\(code.key!.unCapitalized)  != nil {" )
                print("callBackTap?(self.\(code.key!.unCapitalized)!)" )
                print("}" )
                print("}" )
            }
            for labelKey in code.actions.unique() {
                
                if code.key != nil {
                    print("@IBAction func actionTap\(labelKey.firstCapitalized)(_ UIButton: Any) {")
                    print("if self.\(code.key!.unCapitalized)  != nil {" )
                    print("callBackTap\(labelKey.firstCapitalized)?(self.\(code.key!.unCapitalized)!)" )
                    print("}" )
                    print("}" )
                    
                } else {
                    print("@IBAction func actionTap\(labelKey.firstCapitalized)(_ UIButton: Any) {")
                    print("callBackTap\(labelKey.firstCapitalized)?()" )
                    print("}" )
                }
                
            }
            print("}")
            print("")
            }
        func build() {
            if type == .table {
                tableBuilder()

            }else if type == .collectionTable {
                 collectionBuilder()
            }
        }
    }
}
class KeyOb : UIViewController{
    
    var some : String?
    
    func d(){
        

        
    }
    
}



