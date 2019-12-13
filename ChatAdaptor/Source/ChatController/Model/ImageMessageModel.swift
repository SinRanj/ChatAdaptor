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
    
    
    var condition: messageCondition!
    
    var date: String?
    
    var status: messageStatus?
    
    var avatar: UIImage?
    
    var image: UIImage!
 
    var name:String!
    
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
