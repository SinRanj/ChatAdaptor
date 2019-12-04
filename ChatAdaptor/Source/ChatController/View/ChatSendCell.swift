//
//  ChatCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/4/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ChatSendCell: ChatCell {

    let status = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(status)
        status.text = "Seen"
        
        messageLabel.identifier = "messageLabel"
        bubleView.identifier = "bubleView"
        constraintWithCustomMargin(view: messageLabel, left: 100, leftRelation: .greaterThanOrEqual, right: -40, top: 12, bottom: -20)
        constraintWithLeadingAndTrailing(view: bubleView, left: -8, right: 8, top: -8, bottom: 8, secondView: messageLabel)
        constraintWithLeadingAndTrailing(view: dateLabel, left: 0, right: 0, top: 0,topActive: false, bottom: 20, secondView: messageLabel)
        
        constraintLeftWithAnotherView(view: status, rightView: bubleView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}






