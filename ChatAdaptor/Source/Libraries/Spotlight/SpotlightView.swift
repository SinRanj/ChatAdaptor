//
//  SpotlightView.swift
//  ChatAdaptor
//
//  Created by Sina on 12/9/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

class SpotlightView: UIView {
    private var fillLayer = CAShapeLayer()
    private var path : UIBezierPath!
    private var parentView:UIWindow!
    var opacity:Float = 0.7
    private var tapGesture:UITapGestureRecognizer!
    var isApear = false
    private var menu:ChatMenu!
    private var menuFrame:CGRect!
    
    init(view:UIView) {
        super.init(frame: view.frame)
        let rootViewController = UIApplication.shared.windows.first
        parentView = rootViewController
        resetLayers()
        self.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        parentView.addGestureRecognizer(tapGesture)
    }
    
    func addSpotlightToView(cell:ChatCell,rect:CGRect){
        resetLayers()
        parentView.layer.addSublayer(fillLayer)
        parentView.addSubview(self)
        var items = [ChatMenuItem]()
        items.append(ChatMenuItem(title: "Edit"))
        items.append(ChatMenuItem(title: "Reply"))
        items.append(ChatMenuItem(title: "Delete"))
        let height:CGFloat = (CGFloat(items.count*40))
        
        if rect.origin.y >= height+40.0 {
            if cell.bubleView.frame.origin.x <= 50 {
                menuFrame = CGRect(x: 10, y: rect.origin.y-height, width: 150, height: height)
            }
            else {
                menuFrame = CGRect(x: cell.frame.width-160, y: rect.origin.y-height, width: 150, height: height)
            }

        }
        else {
            if cell.bubleView.frame.origin.x <= 50 {
                menuFrame = CGRect(x: 10, y: rect.origin.y+(rect.height)-10, width: 150, height: height)
            }
            else {
                menuFrame = CGRect(x: cell.frame.width-160, y: rect.origin.y+(rect.height)-10, width: 150, height: height)
            }
        }

        menu = ChatMenu(frame: menuFrame, items: items)
        menu.show()
        
        let j = parentView.convert(cell.bubleView.frame, from: cell.bubleView.superview!)
        let spotlightPath = UIBezierPath(roundedRect: CGRect(x: j.origin.x, y: j.origin.y, width: cell.bubleView.frame.width, height: cell.bubleView.frame.height), cornerRadius: 8)
        
        path.append(spotlightPath)
        fillLayer.path = path.cgPath

        let appearAnimation = CABasicAnimation(keyPath: "opacity")
        appearAnimation.fromValue = 0.0
        appearAnimation.toValue = opacity
        appearAnimation.duration = 0.2
        appearAnimation.repeatCount = 0
        fillLayer.add(appearAnimation, forKey: "appear")
        isApear = true
        
    }
    private func resetLayers(){
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: parentView.bounds.size.width, height: parentView.bounds.size.height), cornerRadius: 0)
        fillLayer.path = path.cgPath
        
        fillLayer.fillColor = UIColor.darkGray.cgColor
        fillLayer.opacity = opacity
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTapView(){
        let dissapearAnimation = CABasicAnimation(keyPath: "opacity")
        dissapearAnimation.fromValue = opacity
        dissapearAnimation.toValue = 0.0
        dissapearAnimation.duration = 0.2
        dissapearAnimation.repeatCount = 0
        
        fillLayer.removeAnimation(forKey: "appear")
        fillLayer.add(dissapearAnimation, forKey: "dissapear")
        menu.show()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
//            self.fillLayer.removeAnimation(forKey: "dissapear")
//            self.fillLayer.removeFromSuperlayer()
//            self.gestureRecognizers?.removeAll()
//            self.removeFromSuperview()
//            self.isApear = false
//            self.menu.removeFromSuperview()
//        }
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.fillLayer.removeAnimation(forKey: "dissapear")
            self.fillLayer.removeFromSuperlayer()
            self.gestureRecognizers?.removeAll()
            self.removeFromSuperview()
            self.isApear = false
            self.menu.removeFromSuperview()
        })
    }
}
