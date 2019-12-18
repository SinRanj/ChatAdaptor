//
//  UIViewExtensions.swift
//  Chat
//
//  Created by Sina on 12/3/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

private var assocKey : UInt8 = 0
extension UIView {
    
    /// This variable set an extra text(identifier) for any view.
    var identifier:String?{
        get{
            return objc_getAssociatedObject(self, &assocKey) as? String
        }
        set{
            objc_setAssociatedObject(self, &assocKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// This function set constraint to fill parent view(Self).
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter heightConst: Height for constraint(CGFLoat).
    func constraintFiller(view:UIView,heightConst:CGFloat=0){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: heightConst).isActive = true
        
    }
    
    /// This function set view on bottom with custom height.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter heightConst: Height for constraint(CGFLoat).
    /// - Parameter secondView: A view to be on bottom of the first view(Optional).
    func constraintBottomWithCustomHeight(view:UIView,heightConst:CGFloat, secondView:UIView?=nil){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var bottom = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -view.bottomPadding)
        if let secondView = secondView {
            bottom = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: heightConst)
        }
        if let identifier = view.identifier {
            bottom.identifier = "\(identifier) bottomConst"
        }
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0).isActive = true
        
        let height = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: heightConst)
        height.identifier = "heightConst"
        
        NSLayoutConstraint.activate([bottom,height])
    }
    
    /// This function set view on top with custom height.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter bottomView: A view to be on bottom of the first view(Optional).
    func constraintTopWithAnotherView(view:UIView,bottomView:UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bottomView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0).isActive = true
        
    }
    
    /// This function set constraint for view with custom parameters.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter leftConst: Left constraint.
    /// - Parameter leftView: View on the left side of `view`.
    /// - Parameter leftViewAttribute: `NSLayoutConstraint.Attribute` of left view.
    /// - Parameter leftSelfAttribute: `NSLayoutConstraint.Attribute` of `view`.
    /// - Parameter rightConst: Right constraint.
    /// - Parameter rightView: View on the right side of `view`.
    /// - Parameter rightViewAttribute: `NSLayoutConstraint.Attribute` of right view.
    /// - Parameter rightSelfAttribute: `NSLayoutConstraint.Attribute` of `view`.
    /// - Parameter bottomConst: Bottom constraint.
    /// - Parameter bottomView: View on the bottom side of `view`.
    /// - Parameter bottomViewAttribute: `NSLayoutConstraint.Attribute` of bottom view.
    /// - Parameter bottomSelfAttribute: `NSLayoutConstraint.Attribute` of `view`.
    /// - Parameter topConst: Top constraint.
    /// - Parameter topView: View on the top side of `view`.
    /// - Parameter topViewAttribute: `NSLayoutConstraint.Attribute` of top view.
    /// - Parameter topSelfAttribute: `NSLayoutConstraint.Attribute` of `view`.
    /// - Parameter widthConst: Width constraint.
    /// - Parameter heightConst: Height constraint.
    func constraintCustom(view:UIView,leftConst:CGFloat?=nil, leftView:UIView?=nil,leftViewAttribute:NSLayoutConstraint.Attribute = .left,leftSelfAttribute:NSLayoutConstraint.Attribute = .left,rightConst:CGFloat?=nil,rightView:UIView?=nil,rightViewAttribute:NSLayoutConstraint.Attribute = .right,rightSelfAttribute:NSLayoutConstraint.Attribute = .right,bottomConst:CGFloat?=nil,bottomView:UIView?=nil,bottomViewAttribute:NSLayoutConstraint.Attribute = .bottom,bottomSelfAttribute:NSLayoutConstraint.Attribute = .bottom,topConst:CGFloat?=nil,topView:UIView?=nil,topViewAttribute:NSLayoutConstraint.Attribute = .top,topSelfAttribute:NSLayoutConstraint.Attribute = .top,widthConst:CGFloat?=nil,heightConst:CGFloat?=nil){
        view.translatesAutoresizingMaskIntoConstraints = false
        if let leftConst = leftConst {
            NSLayoutConstraint(item: view, attribute: leftSelfAttribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: leftView ?? self, attribute: leftViewAttribute, multiplier: 1, constant: leftConst).isActive = true
        }
        if let rightConst = rightConst {
            NSLayoutConstraint(item: view, attribute: rightSelfAttribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView ?? self, attribute: rightViewAttribute, multiplier: 1, constant: rightConst).isActive = true
        }
        if let topConst = topConst {
            NSLayoutConstraint(item: view, attribute: topSelfAttribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: topView ?? self, attribute: topViewAttribute, multiplier: 1, constant: topConst).isActive = true
        }
        if let bottomConst = bottomConst {
            NSLayoutConstraint(item: view, attribute: bottomSelfAttribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bottomView ?? self, attribute: bottomViewAttribute, multiplier: 1, constant: bottomConst).isActive = true
        }
        if let widthConst = widthConst {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: widthConst).isActive = true
        }
        if let heightConst = heightConst {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: heightConst).isActive = true
        }
    }
    
    /// This function set constraint for `view` with another view on left.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter rightView: View on the right side of `view`.
    /// - Parameter margin: Margin for constrain default is 8.
    func constraintLeftWithAnotherView(view:UIView,rightView:UIView,margin:CGFloat = 8,leftView:UIView?=nil){
        var lView = self
        var attribute = NSLayoutConstraint.Attribute.left
        if leftView != nil {
            attribute = NSLayoutConstraint.Attribute.right
            lView = leftView!
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: margin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -margin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: lView, attribute: attribute, multiplier: 1, constant: margin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -margin).isActive = true
    }
    
    /// This function set constraint for `view` with another view on left with width and height  instead of left and right constraints.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter rightView: View on the right side of `view`.
    /// - Parameter rightMargin: Margin for right constrain default is 8.
    /// - Parameter bottomMargin: Margin for bottom constrain default is 8.
    func constraintLeftWithAnotherViewNoWidthNoHeight(view:UIView,rightView:UIView,rightMargin:CGFloat = 8, bottomMargin:CGFloat = 8){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -bottomMargin).isActive = true
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -rightMargin).isActive = true
    }
    
    /// This function set constraint for `view` with another view on left in center of parent.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter rightView: View on the right side of `view`.
    /// - Parameter rightMargin: Margin for right constrain default is 8.
    /// - Parameter width: Width constraint.
    /// - Parameter height: Height constraint.
    func constraintLeftWithAnotherViewCenter(view:UIView,rightView:UIView,rightMargin:CGFloat = 8, width:CGFloat, height:CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -rightMargin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -rightMargin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: width).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: height).isActive = true
    }
    
    /// This function set constraint for `view` with custom width and height.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter margin: Margin of constrain default is 8.
    /// - Parameter width: Width constraint.
    /// - Parameter height: Height constraint.
    /// - Parameter isLeft: If view shows on left.
    /// - Parameter isRight: If view shows on right.
    func constraintWithCustomWidthAndHeight(view:UIView,margin:CGFloat = 8, width:CGFloat, height:CGFloat, isLeft:Bool=false, isRight:Bool=false){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: margin).isActive = true
        
        
        if !isLeft {
            if isRight {
                NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -margin).isActive = true
            }
            else {
                NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -margin).isActive = true
                NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -margin).isActive = true
            }

        }
        else {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: margin).isActive = true
        }
        

        let width = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: width)
        if let identifier = view.identifier {
            width.identifier = "\(identifier) widthConst"
        }
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: height).isActive = true
        
        NSLayoutConstraint.activate([width])
        
    }
    
    /// This function set constraint for `view` with custom margin.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter left: Left constraint.
    /// - Parameter leftRelation: `NSLayoutConstraint.Relation` for left constraint.
    /// - Parameter right: Right constraint.
    /// - Parameter rightRelation: `NSLayoutConstraint.Relation` for right constraint.
    /// - Parameter top: Top constraint.
    /// - Parameter topRelation: `NSLayoutConstraint.Relation` for top constraint.
    /// - Parameter bottom: Bottom constraint.
    /// - Parameter bottomRelation: `NSLayoutConstraint.Relation` for bottom constraint.
    /// - Parameter leftView: A view on the left side.
    /// - Parameter rightView: A view on the right side.
    /// - Parameter width: Width constraint.
    func constraintWithCustomMargin(view:UIView, left:CGFloat, leftRelation:NSLayoutConstraint.Relation = .equal, right:CGFloat, rightRelation:NSLayoutConstraint.Relation = .equal,top:CGFloat,topRelation:NSLayoutConstraint.Relation = .equal, bottom:CGFloat,bottomRelation:NSLayoutConstraint.Relation = .equal, leftView:UIView?=nil, rightView:UIView?=nil, width:CGFloat?=nil){
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: topRelation, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top).isActive = true
        
        let bottom = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: bottomRelation, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: bottom)
        
        if let identifier = view.identifier {
            bottom.identifier = "\(identifier) bottomConst"
        }
        
        if width != nil {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: width!).isActive = true
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: width!).isActive = true
        }
        if let leftView = leftView {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: leftRelation, toItem: leftView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: left).isActive = true
        }
        else {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: leftRelation, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: left).isActive = true
        }
        if let rightView = rightView {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: rightRelation, toItem: rightView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: right).isActive = true
            NSLayoutConstraint.activate([bottom])
        }
        else {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: rightRelation, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: right).isActive = true
            NSLayoutConstraint.activate([bottom])
        }
    }
    
    /// This function set constraint for `view` with leading and trailing.
    /// - Parameter view: A view to set constraint for (`view`).
    /// - Parameter left: Left constraint.
    /// - Parameter right: Right constraint.
    /// - Parameter top: Top constraint.
    /// - Parameter topActive: If top constraint should be active.
    /// - Parameter bottom: Bottom constraint.
    /// - Parameter secondView: A view to be on bottom of the first view(Optional).
    func constraintWithLeadingAndTrailing(view:UIView, left:CGFloat, right:CGFloat,top:CGFloat,topActive:Bool=true, bottom:CGFloat, secondView:UIView ){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if topActive {
            NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top).isActive = true
        }
        
        let bottom = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: bottom)
        
        if let identifier = view.identifier {
            bottom.identifier = "\(identifier) bottomConst"
        }
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: left).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: secondView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: right).isActive = true
        
        NSLayoutConstraint.activate([bottom])
    }
    
    /// This functions find constraint based on identifier.
    /// - Parameter identifier: An string identifier to be search in constrains.
    func constraintFinder(identifier:String)->NSLayoutConstraint?{
        var constraint:NSLayoutConstraint?
        for i in constraints {
            if i.identifier == identifier {
                constraint = i
            }
        }
        return constraint
    }
    
    /// This function set corner radius for view.
    /// - Parameter radius: A radius for corners default value is 8.
    func cornerRadius(radius:CGFloat=8){
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    /// This functio draw a line on top of view.
    /// - Parameter start: Start point of line.
    /// - Parameter end: End point of line.
    /// - Parameter color: Color of line.
    func drawLine(fromPoint start: CGPoint, toPoint end: CGPoint,color:CGColor = UIColor.gray.cgColor) {
        let line = CAShapeLayer()
        line.name = "line"
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 1.0
        line.strokeColor = color
        self.layer.addSublayer(line)
    }
    
    /// This function removes line from view.
    func removeLine(){
        if let layers = self.layer.sublayers {
            for i in layers {
                if i.name == "line" {
                    i.removeFromSuperlayer()
                }
            }
        }

    }
    
    /// If iPhone hast notch.
    var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    /// The bottom padding for iPhones with notch.
    var bottomPadding:CGFloat {
        if #available(iOS 11.0, *) {
            guard let bottomPadding = UIApplication.shared.windows.first?.safeAreaInsets.bottom else { return 0 }
            return bottomPadding
        }
        return 0
    }

    /// This functio save view as UIImage.
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
