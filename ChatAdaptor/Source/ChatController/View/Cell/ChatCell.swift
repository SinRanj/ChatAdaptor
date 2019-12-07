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
    var bubleViewBackGroundColor:UIColor=UIColor.gray{
        didSet{
            bubleView.backgroundColor = bubleViewBackGroundColor
        }
    }
    var avatarHeight:CGFloat = 30
    
    var hasAvatar:UIImage?=nil{
        didSet{
            setAvatar()
        }
    }
    
    let dateLabel = UILabel()
    let messageLabel = UILabel()
    let avatarView = UIImageView()
    var messageBottomConst:CGFloat = -20
    var bubleBottomConst:CGFloat = 8
    
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
        bubleView.cornerRadius()
        addSubview(bubleView)
        addSubview(messageLabel)
        addSubview(dateLabel)
        addSubview(avatarView)
        
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
