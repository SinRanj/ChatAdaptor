//
//  ImageMessageModel.swift
//  ChatAdaptor
//
//  Created by Sina on 12/10/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit


struct ImageMessageModel: MessageModel {
    
    /// Condition of message(Send or receive)
    var condition: messageCondition!
    
    /// Date of message which shows in bottom right of bubble message.
    var date: String?
    
    /// Status of message(sending, send, receive, seen)
    var status: messageStatus?
    
    /// Avatar image of user
    var avatar: UIImage?
    
    /// Send or received image.
    var image: UIImage!
    
    /// Name or username of user.
    var name:String!
    
    /// Functionality of action(Edit, reply, delete).
    func actionsForType()->[messageAction] {
        var actions = [messageAction]()
        if condition == .send {
            actions.append(messageAction.reply)
            actions.append(messageAction.delete)
        }
        else if condition == .receive {
            actions.append(messageAction.reply)
            actions.append(messageAction.delete)
        }
        return actions
    }
}
