//
//  LeoPinterestLayout.swift
//  Spire
//
//  Created by tecH on 28/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//
import UIKit
import Foundation

//https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html



class LeoPinterestLayout: UICollectionViewLayout {
    //2. Configurable properties
    fileprivate var numberOfColumns = 2
    
    fileprivate var cellPadding: CGFloat = 6
    
    //3. Array to keep a cache of attributes.
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    //4. Content height and size
    fileprivate var contentHeight: CGFloat = 0
    
    var closureSizeForPhotoAtIndexPath : ((_ collectionView: UICollectionView, _ indexPath: IndexPath  ) -> CGSize)?
    
    var isClustoring : Bool = false
    
    @discardableResult
    func withSizeForPhotoAtIndexPath(cell:@escaping ((_ collectionView: UICollectionView,  _ indexPath: IndexPath  ) -> CGSize) ) -> LeoPinterestLayout {
        closureSizeForPhotoAtIndexPath = cell
        return self
    }
    
    fileprivate var contentWidth: CGFloat {
        
        guard let collectionView = collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    func reload(){
        cache.removeAll()
    }
    override func prepare() {
        // 1. Only calculate once
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // 3. Iterates through the list of items in the first section
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            var some = closureSizeForPhotoAtIndexPath?(collectionView , indexPath) ?? CGSize(width: 500, height: 500)
            
            if isClustoring {
                if item > 2 {
                    some =  CGSize(width: 100   , height: 100)
                    
                    
                    
                    let photoHeight : CGFloat = ( some.height / some.width) * columnWidth
                    
                    
                    let height = cellPadding * 2 + photoHeight
                    
                    let frame = CGRect(x: xOffset[1], y: yOffset[1], width: columnWidth, height: height)
                    let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                    
                    // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.transform = CGAffineTransform(scaleX: 1 / CGFloat(item  - 2) , y: 1 / CGFloat( item - 2))
                    //CGAffineTransform(rotationAngle: CGFloat(item - 4) * 1)
                    //  .concatenating(CGAffineTransform(scaleX: 1 / CGFloat(item  - 3) , y: 1 / CGFloat( item - 3)))
                    // attributes.transform3D = CATransform3DMakeScale(1, 1, CGFloat(1 * (( collectionView.numberOfItems(inSection: 0) -   item - 3))))
                    print(  1 / CGFloat(item  - 2))
                    
                    
                    attributes.frame = insetFrame
                    cache.append(attributes)
                    
                    // 6. Updates the collection view content height
                    contentHeight = max(contentHeight, frame.maxY)
                    //  yOffset[column] = yOffset[column] + height
                    
                    column = column < (numberOfColumns - 1) ? (column + 1) : 0
                    
                    
                    
                }else {
                    
                    
                    // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                    
                    let photoHeight : CGFloat = ( some.height / some.width) * columnWidth
                    
                    
                    let height = cellPadding * 2 + photoHeight
                    let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                    let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                    
                    // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    attributes.frame = insetFrame
                    cache.append(attributes)
                    
                    // 6. Updates the collection view content height
                    contentHeight = max(contentHeight, frame.maxY)
                    yOffset[column] = yOffset[column] + height
                    
                    column = column < (numberOfColumns - 1) ? (column + 1) : 0
                }
            }else {
                
                let photoHeight : CGFloat = ( some.height / some.width) * columnWidth
                
                
                let height = cellPadding * 2 + photoHeight
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                // 6. Updates the collection view content height
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
      
     
      
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}
