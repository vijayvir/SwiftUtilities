//
//  LeoTableViewDataSource.swift
//  Grocery_Planner
//
//  Created by tecH on 27/08/19.
//  Copyright © 2019 tecH. All rights reserved.
//

import Foundation
import UIKit

@objc  protocol  LeoTypeCastableTableView  {
    
}

extension  LeoTypeCastableTableView {
    @discardableResult
    func leoGet<T:LeoTypeCastable>( type  me : T.Type ) -> T?   {
        return self as? T ??  nil
        
    }
}

@objc  protocol  LeoTableViewDataSourceable : LeoTypeCastableTableView {
    @objc optional var textLabel : String { get  }
    @objc optional var detailTextLabel : String { get  }
}


class LeoTableViewViewCell : UITableViewCell {
    
    
    var element : LeoTableViewDataSourceable?
    private var closureElememt : ((LeoTableViewDataSourceable)-> Void)?
    
    @discardableResult
    func configure(element : LeoTableViewDataSourceable) -> Self {
        self.element = element
        return self
    }
    @discardableResult
    func withTap(callback : @escaping ((LeoTableViewDataSourceable)-> Void))-> Self {
        closureElememt = callback
        
        return self
    }
    @IBAction func actionTap(_ sender: UIButton?) {
        closureElememt?(element!)
    }
}



class LeoTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var elements : [LeoTableViewDataSourceable] = []
    
    var style : UITableViewCell.CellStyle = .default
    
    convenience init(style : UITableViewCell.CellStyle = .default) {
        self.init()
        self.style = style
        
    }
    var closureCellForIndexPath : ((_ tableView: UITableView, _ indexPath: IndexPath , _ element : LeoTableViewDataSourceable  ) -> UITableViewCell)?
    
    @discardableResult
    func  withElements(_ value : [LeoTableViewDataSourceable] , _ callback : (()-> Void)? = nil  ) -> LeoTableViewDataSource{
        elements = value
        callback?()
        return self
        
    }
    @discardableResult
    func withCellForIndexPath(cell:@escaping ((_ tableView: UITableView,  _ indexPath: IndexPath , _ element : LeoTableViewDataSourceable  ) -> UITableViewCell) ) -> LeoTableViewDataSource {
        closureCellForIndexPath = cell
        return self
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = closureCellForIndexPath?(tableView,indexPath, elements[indexPath.row]) {
            return cell
            
        }
        let element = elements[indexPath.row]
        let osme =  UITableViewCell(style: style, reuseIdentifier: "Cell")
        osme.textLabel?.text = element.textLabel
        osme.detailTextLabel?.text = element.detailTextLabel
        return osme
    }
    
}
extension UITableView {
    func leoRegister(nibName : String  , identifier : String ){
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier )
        
    }
}
//MARK : USAGE


/*
 //     var datasourse = LeoTableViewDataSource(style: .subtitle)
 
 tableView.dataSource = datasourse
 
 tableView.leoRegister(nibName: "FamilyMemberTableViewCell", identifier: "FamilyMemberTableViewCell")
 
 datasourse.withCellForIndexPath { (tableView,indexPath, element) -> UITableViewCell in
 
 let osme = tableView.dequeueReusableCell(withIdentifier: "FamilyMemberTableViewCell") as!  FamilyMemberTableViewCell
 
 
 
 if let some =  element as? Category_family_listIncomming.Body {
 
 osme.configure(element: some)
 osme.closureTapDelete = { element in
 print(element)
 
 }
 
 }
 
 return osme
 
 }
 
 
 //        if let some = Category_family_listIncomming(dict: json).body {
 //            self.datasourse.withElements(some, {
 //                self.tableView.reloadData()
 //            })
 //        }
 //
 
 */
