//
//  ChatPostSendCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/31/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

class ChatPostSendCell: ChatImageSendCell {
    
    var lockImage = UIImageView()
    var voteLabel = UILabel()
    var voteCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lockImage.image = ChatConfigurations.Icons.icons.lockIcon
        lockImage.tintColor = UIColor.white
        bubbleView.backgroundColor = UIColor.white
        addSubview(lockImage)
        addSubview(voteCountLabel)
        voteCountLabel.text = "1"
        voteCountLabel.font = ChatConfigurations.Fonts.fonts.voteCountFont
        
        constraintCustom(view: cellImageView, rightConst: -10,rightView: avatarView,rightViewAttribute: .left,rightSelfAttribute: .right, bottomConst: messageBottomConst, topConst: 12, widthConst: 180, heightConst: 150)
        
        constraintCustom(view: lockImage, rightConst: -4,rightView:cellImageView,rightViewAttribute: .right,rightSelfAttribute: .right , topConst: 8,topView: cellImageView, topViewAttribute: .top, topSelfAttribute: .top, widthConst: 20, heightConst: 20)
        
        constraintCustom(view: voteCountLabel, leftConst: 8, leftView: cellImageView, leftViewAttribute: NSLayoutConstraint.Attribute.left, leftSelfAttribute: NSLayoutConstraint.Attribute.left, topConst: 8, topView: cellImageView, topViewAttribute: NSLayoutConstraint.Attribute.top, topSelfAttribute: NSLayoutConstraint.Attribute.top, heightConst: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
