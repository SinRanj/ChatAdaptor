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
        statusLabel.font = UIFont(name: dateLabel.font.fontName, size: 14)
        
        constraintWithCustomWidthAndHeight(view: avatarView, margin: 8, width: avatarHeight, height: avatarHeight, isRight: true)
        
        constraintWithCustomMargin(view: cellImageView, left: 100, leftRelation: .greaterThanOrEqual, right: -10, top: 12, bottom: messageBottomConst, rightView: avatarView,width:200)
        constraintWithLeadingAndTrailing(view: bubbleView, left: -4, right: 4, top: -4, bottom: 4, secondView: cellImageView)
        constraintWithLeadingAndTrailing(view: dateLabel, left: 0, right: 0, top: 0,topActive: false, bottom: 20, secondView: cellImageView)
        
        constraintLeftWithAnotherViewNoWidthNoHeight(view: statusLabel, rightView: bubbleView,bottomMargin: 15)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didSetStatus(){
        statusLabel.text = status
    }
}
