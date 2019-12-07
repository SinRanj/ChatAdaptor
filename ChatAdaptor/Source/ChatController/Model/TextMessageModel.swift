//
//  TextMessageModel.swift
//  ChatAdaptor
//
//  Created by Sina on 12/6/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

struct TextMessageModel: MessageModel {
    
    var condition: messageCondition!
    var date: String?
    var status: messageStatus?
    var text:String!
    var avatar: UIImage?
    
    func mockData()-> [TextMessageModel]{
        var messages = [TextMessageModel]()
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Lorem ipsum", avatar: UIImage(named: "rick-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "2w ago", status: .seen, text: "Lorem ipsum",avatar: UIImage(named: "morty-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "dolor sit amet."))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Maecenas et facilisis est, et feugiat diam. Nam ultricies tortor sed mauris tempus lobortis. Aliquam vel vestibulum nulla, eget feugiat libero"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1w ago", status: .seen, text: "Integer lobortis posuere diam, in dignissim purus vestibulum ac."))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1d ago", status: .receive, text: "Maecenas sed mi vehicula, convallis felis at, efficitur turpis. Praesent pulvinar libero."))
        return messages
    }
}
