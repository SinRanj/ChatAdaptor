//
//  ChatImageSendReceiveCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/10/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

class ChatImageReceiveCell:ChatCell {
    
    /// Image view of message.
    var cellImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bubbleViewBackGroundColor = ChatConfigurations.Colors.colors.receiveBubbleViewBackGroundColor
        
        cellImageView.identifier = "receiveImageView"
        bubbleView.identifier = "bubbleView"
        avatarView.identifier = "avatarView"
        cellImageView.cornerRadius()
        addSubview(cellImageView)
        
        constraintWithCustomWidthAndHeight(view: avatarView, margin: 8, width: avatarHeight, height: avatarHeight, isLeft: true)
        constraintWithCustomMargin(view: cellImageView, left: 10, right: -100, rightRelation:.lessThanOrEqual, top: 12, bottom: messageBottomConst,leftView:avatarView,width:200)

        constraintWithLeadingAndTrailing(view: bubbleView, left: -4, right: 4, top: -4, bottom: 4, secondView: cellImageView)
        constraintWithLeadingAndTrailing(view: dateLabel, left: 0, right: 0, top: 0,topActive: false, bottom: 20, secondView: cellImageView)

        avatarView.backgroundColor = UIColor.red
        avatarView.cornerRadius(radius: avatarHeight/2)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
