//
//  ChatCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/4/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ChatReceiveCell: ChatCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        messageLabel.identifier = "messageLabel"
        bubleView.identifier = "bubleView"
        constraintWithCustomMargin(view: messageLabel, left: 40, right: -100, rightRelation:.lessThanOrEqual, top: 12, bottom: messageBottomConst)
        constraintWithLeadingAndTrailing(view: bubleView, left: -8, right: 8, top: -8, bottom: bubleBottomConst, secondView: messageLabel)
        constraintWithLeadingAndTrailing(view: dateLabel, left: 0, right: 0, top: 0,topActive: false, bottom: 20, secondView: messageLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
