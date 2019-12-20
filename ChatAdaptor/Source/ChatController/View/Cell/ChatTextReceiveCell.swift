//
//  ChatCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/4/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ChatTextReceiveCell: ChatCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bubleViewBackGroundColor = ChatConfigurations.Colors.colors.receiveBubleViewBackGroundColor
        messageLabel.identifier = "messageLabel"
        bubleView.identifier = "bubleView"
        avatarView.identifier = "avatarView"
        constraintWithCustomWidthAndHeight(view: avatarView, margin: 8, width: avatarHeight, height: avatarHeight, isLeft: true)
        constraintWithCustomMargin(view: messageLabel, left: 10, right: -100, rightRelation:.lessThanOrEqual, top: 12, bottom: messageBottomConst,leftView:avatarView )
        constraintWithLeadingAndTrailing(view: bubleView, left: -8, right: 8, top: -8, bottom: bubleBottomConst, secondView: messageLabel)
        constraintWithLeadingAndTrailing(view: dateLabel, left: 0, right: 0, top: 0,topActive: false, bottom: 20, secondView: messageLabel)

        avatarView.backgroundColor = UIColor.red
        avatarView.cornerRadius(radius: avatarHeight/2)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
