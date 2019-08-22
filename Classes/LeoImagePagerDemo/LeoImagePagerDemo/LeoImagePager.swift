//
//  LeoImagePager.swift
//  LeoImagePagerDemo
//
//  Created by tecH on 19/08/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//

import UIKit
import UIKit


public class LeoImagePagerViewFlowLayout: UICollectionViewFlowLayout {
    
    override public func prepare() {
        
        super.prepare()
        scrollDirection = .horizontal
       // estimatedItemSize = CGSize(width: 140, height: 40)
    }
  
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        
        let collectionViewSize: CGSize = self.collectionView!.bounds.size
        let rectBounds: CGRect = self.collectionView!.bounds
        let halfWidth: CGFloat = rectBounds.size.width * CGFloat(0.50)
        let proposedContentOffsetCenterX: CGFloat = proposedContentOffset.x + halfWidth
        
        let proposedRect: CGRect = self.collectionView!.bounds
        
        let attributesArray: NSArray = self.layoutAttributesForElements(in: proposedRect)! as NSArray
        
        var candidateAttributes:UICollectionViewLayoutAttributes?
        
        
        for layoutAttributes  in attributesArray {
            
            if let _layoutAttributes = layoutAttributes as? UICollectionViewLayoutAttributes {
                
                if _layoutAttributes.representedElementCategory != UICollectionView.ElementCategory.cell {
                    continue
                }
                
                if candidateAttributes == nil {
                    candidateAttributes = _layoutAttributes
                    continue
                }
                
                if fabsf(Float(_layoutAttributes.center.x) - Float(proposedContentOffsetCenterX)) < fabsf(Float(candidateAttributes!.center.x) - Float(proposedContentOffsetCenterX)) {
                    candidateAttributes = _layoutAttributes
                }
                
            }
        }
        
        if attributesArray.count == 0 {
            return CGPoint(x: proposedContentOffset.x - halfWidth * 2,y: proposedContentOffset.y)
        }
        
        return CGPoint(x: candidateAttributes!.center.x - halfWidth, y: proposedContentOffset.y)
    }
}


@objc  protocol  LeoImagePagerElementable {
   @objc  optional var leoText : String { get }
    
    var leoImage : UIImage  { get }
}

class LeoImagePagerView: UIView {

 
    
    
    lazy var collectionView: UICollectionView  = {
    
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: LeoImagePagerViewFlowLayout())
        collectionView.bounces = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
  
        collectionView.register(LeoImagePagerCollectionViewCell.self,
                                forCellWithReuseIdentifier: "LeoImagePagerCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
      //  collectionView.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        self.addSubview(collectionView)
    
    }
    func setTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: seconds ,
                                         target: self,
                                         selector: #selector(self.autoScroll),
                                         userInfo: nil, repeats: true)
        }
        
  
    }
    
    
    var timer : Timer?
    
 
    @IBInspectable var contentMode0_12 : Int = 1
    @IBInspectable var seconds : Double = 1
    var pager : UIPageControl?
    
      @IBInspectable  var currentDotColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      @IBInspectable  var dotColor : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable var addPager :Bool = false {
        didSet {
            if addPager {
                if pager == nil {
                    pager = UIPageControl(frame: CGRect(x: 50, y: self.bounds.maxY - 20 , width: 200, height: 20))
           
             
                    
                    self.addSubview(pager!)
                }
            }
        }
    }
    
    var elements : [LeoImagePagerElementable] =  []
    var currentIndex : Int  = 0 {
        willSet {
            
        }
        didSet {

        }
    }
    
    @IBInspectable var isTimerEnable : Bool = false {
        didSet {
            if isTimerEnable {
                setTimer()
            }
          
            
        }
    }
    
    @discardableResult
    func configure( elements:  [LeoImagePagerElementable]  , closure : (() -> ())?  ) -> LeoImagePagerView {
        self.elements = elements
        collectionView.reloadData()
        pager?.currentPageIndicatorTintColor = currentDotColor
        pager?.pageIndicatorTintColor = dotColor
        pager?.numberOfPages = self.elements.count
        pager?.frame = CGRect(x: 0, y: self.bounds.maxY - 20 , width: self.bounds.maxX, height: 20)
        collectionView.frame =  self.bounds
        closure?()
        return self
        
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateCellsLayout()
    }
    
    func updateCellsLayout()  {
        /*  let centerX = collectionView.contentOffset.x + (collectionView.frame.size.width)
         for cell in collectionView.visibleCells {
         var offsetX = centerX - cell.center.x
         if offsetX < 0 {
         offsetX *= -1
         }
         cell.transform = CGAffineTransform.identity
         let offsetPercentage = offsetX / (view.bounds.width * 2.7)
         let scaleX = 1-offsetPercentage
         cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
         }*/
        let center = self.convert(collectionView.center, to: collectionView)
        if let middleCellIndexPath = collectionView.indexPathForItem(at: center) {
      //      self.pageControlTop.currentPage = middleCellIndexPath.row
        }
        
    }
    
    
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        updateCellsLayout(collectionView: collectionVIewTop)
//        updateCellsLayout(collectionView: collectionViewCategory)
//
//    }
    

    
}
extension LeoImagePagerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
//        let cellSize = CGSize(width: UIScreen.main.bounds.size.width - (2 * 50) - (2 * 5), height: collectionView.bounds.size.height)
//        return cellSize
        
        return CGSize(width: (UIScreen.main.bounds.size.width) , height: collectionView.bounds.size.height)
    }
    
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
//    {
//        return 50
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
//    {
//        let sectionInset = UIEdgeInsets(top: 0, left: 50 + 5, bottom: 0, right: 50 + 5)
//        return sectionInset
//    }
    
}
extension LeoImagePagerView :UIScrollViewDelegate {
    
    
    
    @objc func autoScroll() {
        
        if self.currentIndex < self.elements.count {
            
            let indexPath = IndexPath(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = self.currentIndex + 1
        } else {
            self.currentIndex = 0
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let soem = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
          pager?.currentPage = soem
        self.currentIndex = soem
        autoScroll()
        print(#function)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
       //    print(scrollView.contentOffset.x / scrollView.frame.size.width  ,  currentIndex  )
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let soem = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
          pager?.currentPage = soem 
    }
    
}
extension LeoImagePagerView  : UICollectionViewDataSource  , UICollectionViewDelegate  {
 
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeoImagePagerCollectionViewCell",
            
                                                      for: indexPath) as! LeoImagePagerCollectionViewCell
        
        cell.configure(element: elements[indexPath.row], contentMode: contentMode0_12)
        
       cell.backgroundColor = .clear
      
        
        return cell
        
    }
    
    
}
class  LeoImagePagerCollectionViewCell  : UICollectionViewCell {
    
    
    
    var label : UILabel?
    var imageView : UIImageView?
 
    
    func configure( element : LeoImagePagerElementable ,  contentMode : Int  ){
        
        
        if imageView == nil {
            
            imageView = UIImageView(frame: bounds)
            contentView.addSubview(imageView!)
        }
        
        
        if label == nil  {
            label = UILabel(frame: bounds)
          
            label?.textAlignment = .center
            
             contentView.addSubview(label!)
        }
        //   label?.text = element.text
         imageView?.contentMode = UIView.ContentMode(rawValue: contentMode) ?? .scaleAspectFit
        imageView?.image = element.leoImage
       
    
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
