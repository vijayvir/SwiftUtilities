//
//  LeoCollectionViewDataSource.swift
//  Spire
//
//  Created by tecH on 28/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import Foundation
import UIKit
// https://medium.com/monstar-lab-bangladesh-engineering/step-into-swift-combine-c0c6daaa3f6e

@objc  protocol  LeoTypeCastable  {
    
}

extension  LeoTypeCastable {
    @discardableResult
    func leoGet<T:LeoTypeCastable>( type  me : T.Type ) -> T?   {
        return self as? T ??  nil
        
    }
}

@objc  protocol  LeoCollectionViewDataSourceable :class, LeoTypeCastable {
    
}





// MARK: CollectionVirew

class LeoCollectionViewCell : UICollectionViewCell{
    
    
    var element : LeoCollectionViewDataSourceable?
    private var closureElememt : ((LeoCollectionViewDataSourceable)-> Void)?
    
    @discardableResult
    func configure(element : LeoCollectionViewDataSourceable) -> Self {
        self.element = element
        return self
    }
    @discardableResult
    func withTap(callback : @escaping ((LeoCollectionViewDataSourceable)-> Void))-> Self {
        closureElememt = callback
        
        return self
    }
    @IBAction func actionTap(_ sender: UIButton?) {
        closureElememt?(element!)
    }
}

class LeoCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var elements : [LeoCollectionViewDataSourceable] = []
    
    var closureCellForIndexPath : ((_ collectionView: UICollectionView, _ indexPath: IndexPath , _ element : LeoCollectionViewDataSourceable  ) -> UICollectionViewCell)?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = closureCellForIndexPath?(collectionView,indexPath, elements[indexPath.row]) {
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
        
    }
    @discardableResult
    func  withElements(_ value : [LeoCollectionViewDataSourceable] , _ callback : (()-> Void)? = nil  ) -> LeoCollectionViewDataSource{
        elements = value
        callback?()
        return self
    }
    @discardableResult
    func withCellForIndexPath(cell:@escaping ((_ collectionView: UICollectionView,  _ indexPath: IndexPath , _ element : LeoCollectionViewDataSourceable  ) -> UICollectionViewCell) ) -> LeoCollectionViewDataSource {
        closureCellForIndexPath = cell
        return self
    }
}

extension UICollectionView {
    
    func leoRegister(nibName : String  , identifier : String ){
        
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier )
        
    }
}

//MARK:  UICollectionViewDelegateFlowLayout : delegate

class LeoCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    
    var closureSizeForItemAtIndexPath : ((_ collectionView: UICollectionView, _ indexPath: IndexPath , _ layout : UICollectionViewLayout  ) -> CGSize)?
    
    @discardableResult
    func withSizeForItemAtIndexPat(cell:@escaping ((_ collectionView: UICollectionView,  _ indexPath: IndexPath , _ layout : UICollectionViewLayout  ) -> CGSize) ) -> LeoCollectionViewDelegate {
        closureSizeForItemAtIndexPath = cell
        return self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let minXY = min(collectionView.frame.width, collectionView.frame.height)
        
        return closureSizeForItemAtIndexPath?(collectionView,  indexPath , collectionViewLayout) ?? CGSize(width: minXY/2, height: minXY/2)
    }
}


