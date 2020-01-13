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
    
    let cellImageView2 = UIImageView()
    
    var posts:[PostModel]! {
        willSet {
            for i in newValue.enumerated() {
                let lockImage = UIImageView()
                let voteLabel = UILabel()
                let voteCountLabel = UILabel()
                if i.offset == 0 {
                    cellImageView.identifier = "sendImageView"
                    cellImageView.image = i.element.image
                    cellImageView.contentMode = .scaleAspectFill
                    setConstraints(cellImageView: self.cellImageView, rightView: avatarView, lockImage: lockImage, voteLabel: voteLabel, voteCountLabel: voteCountLabel)
                    lockImage.isHidden = !i.element.isPrivate
                    if i.element.vote != nil {
                        voteLabel.isHidden = false
                        voteCountLabel.text = "\(i.element.vote!)"
                        voteCountLabel.isHidden = false
                        let width = cellImageView.constraintFinder(identifier: "\(cellImageView.identifier!) widthConst")
                        width?.constant += 20
                        
                    }
                    else {
                        voteLabel.isHidden = true
                        voteCountLabel.isHidden = true
                    }
                }
                else {
                    lockImage.isHidden = !i.element.isPrivate
                    cellImageView2.cornerRadius()
                    cellImageView2.contentMode = .scaleAspectFill
                    cellImageView2.image = i.element.image
                    addSubview(cellImageView2)
                    cellImageView2.identifier = "sendImageView2"
                    setConstraints(cellImageView: cellImageView2, rightView: cellImageView,rightConst: -4, lockImage: lockImage, voteLabel: voteLabel, voteCountLabel: voteCountLabel)
                    
                    constraintCustom(view: bubbleView, leftConst: -4, leftView: cellImageView2, leftViewAttribute: .left, leftSelfAttribute: NSLayoutConstraint.Attribute.left, rightConst: 4, rightView: cellImageView, rightViewAttribute: NSLayoutConstraint.Attribute.right, rightSelfAttribute: .right, bottomConst: 4, bottomView: cellImageView, bottomViewAttribute: NSLayoutConstraint.Attribute.bottom, bottomSelfAttribute: NSLayoutConstraint.Attribute.bottom, topConst: -4, topView: cellImageView, topViewAttribute: NSLayoutConstraint.Attribute.top, topSelfAttribute: .top)
                    
                    statusLabel.removeAllConstraints()
                    
                    constraintCustom(view: statusLabel, rightConst: -8, rightView: dateLabel, rightViewAttribute: NSLayoutConstraint.Attribute.left, rightSelfAttribute: NSLayoutConstraint.Attribute.right, topConst: 0, topView: dateLabel, topViewAttribute: NSLayoutConstraint.Attribute.top, topSelfAttribute: NSLayoutConstraint.Attribute.top)
                    let width = cellImageView.constraintFinder(identifier: "\(cellImageView.identifier!) widthConst")
                    let width2 = cellImageView2.constraintFinder(identifier: "\(cellImageView2.identifier!) widthConst")
                    if i.element.vote != nil {
                        voteLabel.isHidden = false
                        voteCountLabel.text = "\(i.element.vote!)"
                        voteCountLabel.isHidden = false
                        if width?.constant != width2?.constant {
                            width?.constant = width2?.constant ?? 0
                        }
                        else {
                            width2?.constant += 20
                            width?.constant -= 20
                        }
                    }
                    else {
                        voteLabel.isHidden = true
                        voteCountLabel.isHidden = true
                        if width?.constant != width2?.constant {
                            width2?.constant -= 20
                        }
                    }
                    
                }
                
                //                if i.element.vote != nil {
                //                    let width = cellImageView.constraintFinder(identifier: "\(cellImageView.identifier!) widthConst")
                //                    width?.constant += 20
                //                    self.layoutIfNeeded()
                //                }
            }
            
        }
    }
    private func setConstraints(cellImageView:UIImageView,rightView:UIView,rightConst:CGFloat = -10, lockImage:UIImageView, voteLabel:UILabel, voteCountLabel:UILabel){
        lockImage.image = ChatConfigurations.Icons.icons.lockIcon
        lockImage.tintColor = UIColor.white
        
        bubbleView.backgroundColor = UIColor.white
        
        voteCountLabel.font = ChatConfigurations.Fonts.fonts.voteCountFont
        voteCountLabel.textColor = UIColor.white
        
        voteLabel.font = ChatConfigurations.Fonts.fonts.voteFont
        voteLabel.textColor = UIColor.white
        
        addSubview(lockImage)
        addSubview(voteCountLabel)
        addSubview(voteLabel)
        
        voteLabel.text = "Vote"
        
        let width = (UIScreen.main.bounds.width-30-avatarView.frame.width)/2
        constraintCustom(view: cellImageView, rightConst: rightConst,rightView: rightView,rightViewAttribute: .left,rightSelfAttribute: .right, bottomConst: messageBottomConst, topConst: 12, widthConst: width, heightConst: width-15)
        
        constraintCustom(view: lockImage, rightConst: -4,rightView:cellImageView,rightViewAttribute: .right,rightSelfAttribute: .right , topConst: 8,topView: cellImageView, topViewAttribute: .top, topSelfAttribute: .top, widthConst: 20, heightConst: 20)
        
        constraintCustom(view: voteCountLabel, leftConst: 8, leftView: cellImageView, leftViewAttribute: NSLayoutConstraint.Attribute.left, leftSelfAttribute: NSLayoutConstraint.Attribute.left, topConst: 8, topView: cellImageView, topViewAttribute: NSLayoutConstraint.Attribute.top, topSelfAttribute: NSLayoutConstraint.Attribute.top, heightConst: 20)
        
        constraintCustom(view: voteLabel,leftConst: 3, leftView: voteCountLabel, leftViewAttribute: NSLayoutConstraint.Attribute.leading, leftSelfAttribute: NSLayoutConstraint.Attribute.leading, topConst: 0, topView: voteCountLabel, topViewAttribute: NSLayoutConstraint.Attribute.bottom, topSelfAttribute: NSLayoutConstraint.Attribute.top)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
