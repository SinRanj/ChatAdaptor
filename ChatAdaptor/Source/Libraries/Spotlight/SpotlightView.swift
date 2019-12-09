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
    private var parentView:UIView!
    var opacity:Float = 0.7
    private var tapGesture:UITapGestureRecognizer!
    var isApear = false
    
    init(view:UIView) {
        super.init(frame: view.frame)
        parentView = view
        resetLayers()
        self.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGesture)
    }
    
    func addSpotlightToView(cell:ChatCell){
        resetLayers()
        parentView.layer.addSublayer(fillLayer)
        parentView.addSubview(self)
        
        let j = parentView.convert(cell.bubleView.frame, from: cell.bubleView.superview!)
        let spotlightPath = UIBezierPath(roundedRect: CGRect(x: j.origin.x, y: j.origin.y, width: cell.bubleView.frame.width, height: cell.bubleView.frame.height), cornerRadius: 8)
        
        path.append(spotlightPath)
        fillLayer.path = path.cgPath

        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 0.0
        fadeAnimation.toValue = opacity
        fadeAnimation.duration = 0.2
        fadeAnimation.repeatCount = 0
        fillLayer.add(fadeAnimation, forKey: nil)
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
        fillLayer.removeFromSuperlayer()
        gestureRecognizers?.removeAll()
        removeFromSuperview()
        isApear = false
    }
}
