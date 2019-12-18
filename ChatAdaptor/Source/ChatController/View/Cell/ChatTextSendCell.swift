//
//  ChatCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/4/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ChatTextSendCell: ChatCell {
    
    /// Status label of message
    let statusLabel = UILabel()
    
    /// Status of message.
    var status:String=""{
        didSet{
            didSetStatus()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(statusLabel)
        
        avatarView.identifier = "avatarView"
        constraintWithCustomWidthAndHeight(view: avatarView, margin: 8, width: avatarHeight, height: avatarHeight, isRight: true)
        
        avatarView.backgroundColor = UIColor.red
        avatarView.cornerRadius(radius: avatarHeight/2)
        
        bubleViewBackGroundColor = UIColor(red: 88/255, green: 136/255, blue: 140/255, alpha: 1)
        statusLabel.font = UIFont(name: dateLabel.font.fontName, size: 14)
        messageLabel.identifier = "messageLabel"
        bubleView.identifier = "bubleView"


        constraintWithCustomMargin(view: messageLabel, left: 100, leftRelation: .greaterThanOrEqual, right: -10, top: 12, bottom: messageBottomConst, rightView: avatarView)
        constraintWithLeadingAndTrailing(view: bubleView, left: -8, right: 8, top: -8, bottom: 8, secondView: messageLabel)
        constraintWithLeadingAndTrailing(view: dateLabel, left: 0, right: 0, top: 0,topActive: false, bottom: 20, secondView: messageLabel)
        
        constraintLeftWithAnotherViewNoWidthNoHeight(view: statusLabel, rightView: bubleView,bottomMargin: 15)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func didSetStatus(){
        statusLabel.text = status
    }
}






