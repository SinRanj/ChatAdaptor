//
//  ChatCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/4/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    let bubleView = UIView()
    
    var date:String?{
        didSet{
            didSetDate()
        }
    }
    
    var message:String?{
        didSet{
            messageLabel.text = message
        }
    }
    
    let dateLabel = UILabel()
    let messageLabel = UILabel()
    var messageBottomConst:CGFloat = -20
    var bubleBottomConst:CGFloat = 8
    
    private func didSetDate(){
        dateLabel.text = date
        var bottomConst = constraintFinder(identifier: "messageLabel bottomConst")
        bottomConst?.constant += -17
        bottomConst = constraintFinder(identifier: "bubleView bottomConst")
        bottomConst?.constant += 17
        layoutIfNeeded()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bubleView.backgroundColor = UIColor.gray
        bubleView.cornerRadius()
        addSubview(bubleView)
        addSubview(messageLabel)
        addSubview(dateLabel)
        selectionStyle = .none
        messageLabel.numberOfLines = 0
        dateLabel.font = UIFont(name: dateLabel.font.fontName, size: 14)
        dateLabel.textAlignment = .right
        dateLabel.textColor = UIColor.white
        messageLabel.textColor = UIColor.white
        messageLabel.adjustsFontSizeToFitWidth = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
