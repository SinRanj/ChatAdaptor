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
    var identifier:String?{
        get{
            return objc_getAssociatedObject(self, &assocKey) as? String
        }
        set{
            objc_setAssociatedObject(self, &assocKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func constraintFiller(view:UIView,heightConst:CGFloat=0){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: heightConst).isActive = true
        
    }
    
    func constraintBottomWithCustomHeight(view:UIView,heightConst:CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bottom = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        bottom.identifier = "bottomConst"
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0).isActive = true
        
        
        let height = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: heightConst)
        height.identifier = "heightConst"
        
        NSLayoutConstraint.activate([bottom,height])
    }
    func constraintTopWithAnotherView(view:UIView,bottomView:UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bottomView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0).isActive = true
        
    }
    func constraintLeftWithAnotherView(view:UIView,rightView:UIView,margin:CGFloat = 8){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: margin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -margin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: margin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -margin).isActive = true
    }
    
    func constraintLeftWithAnotherViewNoWidthNoHeight(view:UIView,rightView:UIView,rightMargin:CGFloat = 8, bottomMargin:CGFloat = 8){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -bottomMargin).isActive = true
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -rightMargin).isActive = true
    }
    
    func constraintLeftWithAnotherViewCenter(view:UIView,rightView:UIView,rightMargin:CGFloat = 8, width:CGFloat, height:CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -rightMargin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: rightView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: -rightMargin).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: width).isActive = true
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: height).isActive = true
    }
    
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
    
    func constraintWithCustomMargin(view:UIView, left:CGFloat, leftRelation:NSLayoutConstraint.Relation = .equal, right:CGFloat, rightRelation:NSLayoutConstraint.Relation = .equal,top:CGFloat,topRelation:NSLayoutConstraint.Relation = .equal, bottom:CGFloat,bottomRelation:NSLayoutConstraint.Relation = .equal, leftView:UIView?=nil, rightView:UIView?=nil){
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: topRelation, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top).isActive = true
        
        let bottom = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: bottomRelation, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: bottom)
        
        if let identifier = view.identifier {
            bottom.identifier = "\(identifier) bottomConst"
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
    
    func constraintFinder(identifier:String)->NSLayoutConstraint?{
        var constraint:NSLayoutConstraint?
        for i in constraints {
            if i.identifier == identifier {
                constraint = i
            }
        }
        return constraint
    }
    
    func cornerRadius(radius:CGFloat=8){
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
}
