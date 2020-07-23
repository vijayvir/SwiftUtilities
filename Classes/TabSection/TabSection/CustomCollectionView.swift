//
//  CustomCollectionView.swift
//  TabSection
//
//  Created by Manas Sharma on 6/7/20.
//  Copyright © 2020 Manas. All rights reserved.
//

import UIKit

class CustomCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private lazy var movableView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: bounds.maxY - 2, width: UIScreen.main.bounds.maxX / 3, height: 2))
        view.backgroundColor = #colorLiteral(red: 1, green: 0.09799999744, blue: 0.1369999945, alpha: 1)
        return view
    }()
    
    private func commonInit() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.maxX / 3, height: bounds.maxY)
        
        allowsSelection = true
        
        collectionViewLayout = layout
        addSubview(movableView)
    }
    
    func scrollTo(_ index: IndexPath) {
        if index.row == 0 {
            print("First item")
            scrollToItem(at: index, at: .left, animated: true)
        } else if index.row == numberOfItems(inSection: index.section) - 1 {
            print("Last item")
            scrollToItem(at: IndexPath(item: numberOfItems(inSection: index.section) - 1, section: 0), at: .right, animated: true)
        } else {
            print("Any other")
            scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
        
        layoutAttributesForItem(at: index).map { attribute in
            UIView.animate(withDuration: 0.2) {
                self.movableView.frame.origin.x = attribute.frame.origin.x
            }
        }
    }
    
}
