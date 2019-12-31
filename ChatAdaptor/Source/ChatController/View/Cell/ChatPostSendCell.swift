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
    
    var isPrivate:Bool = false{
        willSet {
            lockImage.isHidden = !newValue
        }
    }
    var voteCount:Int = 0 {
        willSet {
            if newValue > 0 {
                voteCountLabel.text = "\(newValue)"
                voteCountLabel.isHidden = false
                voteLabel.isHidden = false
            }
            else {
                voteCountLabel.isHidden = true
                voteLabel.isHidden = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lockImage.image = ChatConfigurations.Icons.icons.lockIcon
        lockImage.tintColor = UIColor.white
        lockImage.isHidden = !isPrivate
        
        bubbleView.backgroundColor = UIColor.white
        
        voteCountLabel.font = ChatConfigurations.Fonts.fonts.voteCountFont
        voteCountLabel.textColor = UIColor.white
        
        voteLabel.font = ChatConfigurations.Fonts.fonts.voteFont
        voteLabel.textColor = UIColor.white
        
        addSubview(lockImage)
        addSubview(voteCountLabel)
        addSubview(voteLabel)
        
        voteLabel.text = "Vote"
        voteLabel.isHidden = true
        
        constraintCustom(view: cellImageView, rightConst: -10,rightView: avatarView,rightViewAttribute: .left,rightSelfAttribute: .right, bottomConst: messageBottomConst, topConst: 12, widthConst: 180, heightConst: 150)
        
        constraintCustom(view: lockImage, rightConst: -4,rightView:cellImageView,rightViewAttribute: .right,rightSelfAttribute: .right , topConst: 8,topView: cellImageView, topViewAttribute: .top, topSelfAttribute: .top, widthConst: 20, heightConst: 20)
        
        constraintCustom(view: voteCountLabel, leftConst: 8, leftView: cellImageView, leftViewAttribute: NSLayoutConstraint.Attribute.left, leftSelfAttribute: NSLayoutConstraint.Attribute.left, topConst: 8, topView: cellImageView, topViewAttribute: NSLayoutConstraint.Attribute.top, topSelfAttribute: NSLayoutConstraint.Attribute.top, heightConst: 20)
        
        constraintCustom(view: voteLabel,leftConst: 3, leftView: voteCountLabel, leftViewAttribute: NSLayoutConstraint.Attribute.leading, leftSelfAttribute: NSLayoutConstraint.Attribute.leading, topConst: 0, topView: voteCountLabel, topViewAttribute: NSLayoutConstraint.Attribute.bottom, topSelfAttribute: NSLayoutConstraint.Attribute.top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
