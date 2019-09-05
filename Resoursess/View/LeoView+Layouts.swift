//
//  SCAddCommentView.swift
//  Spire
//
//  Created by tecH on 04/09/19.
//  Copyright © 2019 vijayvir Singh. All rights reserved.
//
import Foundation

extension UIView {
    
    @discardableResult
    class func leoRegister<T:Any>(type  me : T.Type)-> T? {
        
        if let element =  Bundle.main.loadNibNamed("\(me)", owner: self, options: nil)?.first as? T {
            return element
        }
        return nil
    }
}


extension UIView {
    
    enum Constraints : Hashable{
        case top(margin : CGFloat)
        case bottom(margin : CGFloat)
        case leading(margin : CGFloat)
        case trailing(margin : CGFloat)
    }
    
    /// attaches all sides of the receiver to its parent view
func leoConstraints(constraints : [Constraints]  = [.top(margin: 0) ,
                                                    .bottom(margin: 0) ,
                                                    .leading(margin: 0)  ,
                                                    .trailing(margin: 0)]  ) {
         self.translatesAutoresizingMaskIntoConstraints = false
        let view = superview
        for element in constraints {
            switch element {
            case .top(let margin):
                layoutAttachTop(to: view, margin: margin)
            case .bottom(let margin):
                layoutAttachBottom(to: view, margin: margin)
            case .leading(let margin):
                layoutAttachLeading(to: view, margin: margin)
            case .trailing(let margin):
                layoutAttachTrailing(to: view, margin: margin)
            }
        }

        view?.layoutIfNeeded()
    }
    
    /// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
}



