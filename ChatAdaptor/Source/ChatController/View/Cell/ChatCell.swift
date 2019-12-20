//
//  ChatCell.swift
//  ChatAdaptor
//
//  Created by Sina on 12/4/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    /// Bubble view of message.
    let bubleView = UIView()
    
    /// Date of received or sent message.
    var date:String?{
        didSet{
            didSetDate()
        }
    }
    
    /// Text message received or sent.
    var message:String?{
        didSet{
            messageLabel.text = message
        }
    }
    
    /// Background color for bubble message.
    var bubleViewBackGroundColor:UIColor=UIColor.gray{
        didSet{
            bubleView.backgroundColor = bubleViewBackGroundColor
        }
    }
    
    /// Height of avatarView.
    var avatarHeight:CGFloat = 30
    
    /// Set avatar shows in left or right side of message bubble. The message bubble will move based on it.
    var hasAvatar:UIImage?=nil{
        didSet{
            setAvatar()
        }
    }
    
    /// Name or username of user.
    var name:String?
    
    /// Date label.
    let dateLabel = UILabel()
    
    /// Message label.
    let messageLabel = UILabel()
    
    /// Avatar View.
    let avatarView = UIImageView()
    
    /// Default constraint for borrom of message.
    var messageBottomConst:CGFloat = -20
    
    
    /// Default constraint for borrom of bubble.
    var bubleBottomConst:CGFloat = 8
    
    /// This function set avatar and move bubble and message based on it.
    private func setAvatar(){
        let widthConst = avatarView.constraintFinder(identifier: "avatarView widthConst")
        if let avatar = hasAvatar {
            let widthConst = avatarView.constraintFinder(identifier: "avatarView widthConst")
            widthConst?.constant = avatarHeight
            avatarView.image = avatar   
        }
        else {
            widthConst?.constant = 0
        }
        layoutIfNeeded()
    }
    
    /// This function set date of message and move bubble and message based on it
    private func didSetDate(){
        if let date = date {
            dateLabel.text = date
            var bottomConst = constraintFinder(identifier: "messageLabel bottomConst")
            if bottomConst?.constant == messageBottomConst {
                bottomConst?.constant += -17
            }
            bottomConst = constraintFinder(identifier: "bubleView bottomConst")
            if bottomConst?.constant == bubleBottomConst {
                bottomConst?.constant += 17
            }
            layoutIfNeeded()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = ChatConfigurations.Colors.colors.chatBackgroundColor
            
        if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
            self.transform = CGAffineTransform(rotationAngle: (-.pi))
        }
        bubleView.cornerRadius()
        addSubview(bubleView)
        addSubview(messageLabel)
        addSubview(dateLabel)
        addSubview(avatarView)
        
        selectionStyle = .none
        messageLabel.numberOfLines = 0
        dateLabel.font = UIFont(name: dateLabel.font.fontName, size: 14)
        dateLabel.textAlignment = .right
        dateLabel.textColor = ChatConfigurations.Colors.colors.bubleTextColor
        messageLabel.textColor = ChatConfigurations.Colors.colors.bubleTextColor
        messageLabel.adjustsFontSizeToFitWidth = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
