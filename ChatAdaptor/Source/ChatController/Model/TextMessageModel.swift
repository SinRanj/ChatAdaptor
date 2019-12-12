//
//  TextMessageModel.swift
//  ChatAdaptor
//
//  Created by Sina on 12/6/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

struct TextMessageModel:MessageModel {
    var condition: messageCondition!
    
    var date: String?
    
    var status: messageStatus?
    
    var text:String!
    
    var avatar: UIImage?
    
    func actionsForType() -> [messageAction] {
        var actions = [messageAction]()
        if condition == .send {
            actions.append(messageAction.edit)
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
