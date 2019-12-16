//
//  SpotlightView.swift
//  ChatAdaptor
//
//  Created by Sina on 12/9/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit


protocol SpotlightDelegate:AnyObject{
    func didSelectItem(action:messageAction, indexPath:IndexPath)
}
class SpotlightView: UIView {
    private var fillLayer = CAShapeLayer()
    private var path : UIBezierPath!
    private var parentView:UIWindow!
    var opacity:Float = 0.7
    private var tapGesture:UITapGestureRecognizer!
    var isApear = false
    private var menu:ChatMenu!
    private var menuFrame:CGRect!
    
    private var actionItems = [messageAction]()
    private var indexPath:IndexPath!
    
    private var messageViewImage:UIImageView!
    private var bubbleViewImage:UIImageView!
    private var dateLabelViewImage:UIImageView!
    
    weak var delegate:SpotlightDelegate?
    
    init(view:UIView) {
        super.init(frame: view.frame)
        let rootViewController = UIApplication.shared.windows.first
        parentView = rootViewController
        resetLayers()
        self.isUserInteractionEnabled = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGesture)
    }
    
    func addSpotlightToView(cell:ChatCell,rect:CGRect,messageActions:[messageAction], indexPath:IndexPath){
        resetLayers()
        parentView.layer.addSublayer(fillLayer)
        parentView.addSubview(self)
        var items = [ChatMenuItem]()
        
        actionItems = messageActions
        self.indexPath = indexPath
        
        for i in messageActions {
            items.append(ChatMenuItem(title: i.rawValue))
        }
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
        menu.delegate = self
        menu.show()
        
        let bubbleImage = cell.bubleView.asImage()
        let bubbleFrame = parentView.convert(cell.bubleView.frame, from: cell.bubleView.superview!)
        bubbleViewImage = UIImageView(frame: bubbleFrame)
        bubbleViewImage.image = bubbleImage
        
        let dateImage = cell.dateLabel.asImage()
        let dateFrame = parentView.convert(cell.dateLabel.frame, from: cell.dateLabel.superview!)
        dateLabelViewImage = UIImageView(frame: dateFrame)
        dateLabelViewImage.image = dateImage
        
        if cell is ChatTextSendCell || cell is ChatTextReceiveCell{
            let messageImage = cell.messageLabel.asImage()
            let messageFrame = parentView.convert(cell.messageLabel.frame, from: cell.messageLabel.superview!)
            messageViewImage = UIImageView(frame: messageFrame)
            messageViewImage.image = messageImage
        }
        else if let c = cell as? ChatImageSendCell  {
            let messageImage = c.cellImageView.asImage()
            let messageFrame = parentView.convert(c.cellImageView.frame, from: c.cellImageView.superview!)
            messageViewImage = UIImageView(frame: messageFrame)
            messageViewImage.image = messageImage
        }
        else if let c = cell as? ChatImageReceiveCell {
            let messageImage = c.cellImageView.asImage()
            let messageFrame = parentView.convert(c.cellImageView.frame, from: c.cellImageView.superview!)
            messageViewImage = UIImageView(frame: messageFrame)
            messageViewImage.image = messageImage
        }
        
        self.addSubview(bubbleViewImage)
        self.addSubview(messageViewImage)
        self.addSubview(dateLabelViewImage)
        
        let spotlightPath = UIBezierPath(roundedRect: CGRect(x: bubbleFrame.origin.x, y: bubbleFrame.origin.y, width: cell.bubleView.frame.width, height: cell.bubleView.frame.height), cornerRadius: 8)
        
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
        if menu != nil {
            menu.show()
        }
        
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
            self.bubbleViewImage.removeFromSuperview()
            self.messageViewImage.removeFromSuperview()
            self.dateLabelViewImage.removeFromSuperview()
            self.fillLayer.removeAnimation(forKey: "dissapear")
            self.fillLayer.removeFromSuperlayer()
            self.removeFromSuperview()
            self.isApear = false
            if self.menu != nil {
                self.menu.removeFromSuperview()
            }
        })
    }
}

extension SpotlightView:ChatMenuDelegate{
    func didSelectItem(index: Int, title: String) {
        didTapView()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
            self.delegate?.didSelectItem(action: self.actionItems[index], indexPath: self.indexPath)
        }
        
    }
    
}
