//
//  ReplyView.swift
//  ChatAdaptor
//
//  Created by Sina on 12/12/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit


class ReplyView:UIView{
    typealias CloseAction = () -> ()
    
    private var closeBtn = UIButton()
    
    var closeAction: CloseAction? = { }
    private var colorView = UIView()
    private var nameLabel = UILabel()
    private var messageLabel = UILabel()
    
    var name:String!{
        didSet{
            nameLabel.text = name ?? ""
        }
    }
    var message:String!{
        didSet{
            messageLabel.text = message
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilizer()
    }
    init(frame:CGRect, closeAction:@escaping ()->Void){
        super.init(frame: frame)
        initilizer()
        self.closeAction = closeAction
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initilizer(){
        backgroundColor = ChatConfigurations.Colors.sharedInstance.chatViewHolderBackGroundColor
        addSubview(closeBtn)
        addSubview(colorView)
        addSubview(nameLabel)
        addSubview(messageLabel)
        
        colorView.backgroundColor = ChatConfigurations.Colors.sharedInstance.randomizeColor()
        constraintCustom(view: colorView, bottomConst: 0, topConst: 0, widthConst: 6)
        drawLine(fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: UIScreen.main.bounds.size.width, y: 0))

        closeBtn.setImage(UIImage(named: "cancel"), for: UIControl.State.normal)
        closeBtn.imageView?.contentMode = .scaleAspectFit
        
        constraintCustom(view: closeBtn, rightConst: -8, topConst: 8, widthConst: 20, heightConst: 20)
        constraintCustom(view: nameLabel, leftConst: 16 ,leftView: self,rightConst:-8,rightView: closeBtn,rightViewAttribute: .left,topConst: 8)
        constraintCustom(view: messageLabel, leftConst: 16 ,leftView: self,rightConst:-8,rightView: closeBtn,rightViewAttribute: .left,topConst: 3,topView: nameLabel,topViewAttribute: .bottom)
        
        nameLabel.text = "test"
        messageLabel.text = "test"
        closeBtn.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func close(){
        closeAction?()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layouts()
    }
    func layouts(){
        self.removeLine()
        self.drawLine(fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: UIScreen.main.bounds.size.width, y: 0))
        
    }
    
}
