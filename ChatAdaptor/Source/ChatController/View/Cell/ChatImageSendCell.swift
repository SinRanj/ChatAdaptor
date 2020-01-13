//
//  ChatImageSendCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/10/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

class ChatImageSendCell: ChatCell {
    
    /// Status label of message.
    let statusLabel = UILabel()
    
    /// Image view of message.
    var cellImageView = UIImageView()
    
    /// Status of message.
    var status:String=""{
        didSet{
            didSetStatus()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(statusLabel)
        cellImageView.identifier = "sendImageView"
        avatarView.identifier = "avatarView"
        bubbleView.identifier = "bubbleView"
        cellImageView.cornerRadius()
        addSubview(cellImageView)
        avatarView.backgroundColor = UIColor.red
        avatarView.cornerRadius(radius: avatarHeight/2)
        bubbleViewBackGroundColor = ChatConfigurations.Colors.colors.sendBubbleViewBackGroundColor
        statusLabel.font = UIFont(name: dateLabel.font.fontName, size: ChatConfigurations.Fonts.fonts.messageFont.pointSize-2)

        
        constraintWithCustomWidthAndHeight(view: avatarView, margin: 8, width: avatarHeight, height: avatarHeight, isRight: true)
        
        constraintWithCustomMargin(view: cellImageView, left: 100, leftRelation: .greaterThanOrEqual, right: -10, top: 12, bottom: messageBottomConst, rightView: avatarView,width:200)
        constraintWithLeadingAndTrailing(view: bubbleView, left: -4, right: 4, top: -4, bottom: 4, secondView: cellImageView)
        constraintCustom(view: dateLabel,rightConst: 0, rightView: cellImageView, rightViewAttribute: NSLayoutConstraint.Attribute.trailing, rightSelfAttribute: NSLayoutConstraint.Attribute.trailing, topConst: 6, topView: cellImageView, topViewAttribute: NSLayoutConstraint.Attribute.bottom, topSelfAttribute: NSLayoutConstraint.Attribute.top)
        
        constraintLeftWithAnotherViewNoWidthNoHeight(view: statusLabel, rightView: bubbleView,bottomMargin: 15)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didSetStatus(){
        statusLabel.text = status
    }
}
