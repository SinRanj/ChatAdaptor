//
//  Message.swift
//  ChatAdaptor
//
//  Created by Sina on 12/6/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

enum messageCondition {
    case send
    case receive
}
enum messageStatus:String {
    case sending = "sending"
    case send = "send"
    case receive = "receive"
    case seen = "seen"
}
protocol MessageModel {
    
    var condition:messageCondition! {get set}
    var date:String? {get set}
    var status:messageStatus? {get set}
    var avatar:UIImage?{get set}
}
extension MessageModel {
    func mockData()-> Array<MessageModel>{
        var messages:Array<MessageModel> = []
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Lorem ipsum", avatar: UIImage(named: "rick-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "2w ago", status: .seen, text: "Lorem ipsum",avatar: UIImage(named: "morty-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "dolor sit amet."))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Maecenas et facilisis est, et feugiat diam. Nam ultricies tortor sed mauris tempus lobortis. Aliquam vel vestibulum nulla, eget feugiat libero"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1w ago", status: .seen, text: "Integer lobortis posuere diam, in dignissim purus vestibulum ac."))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1d ago", status: .receive, text: "Maecenas sed mi vehicula, convallis felis at, efficitur turpis. Praesent pulvinar libero."))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Lorem ipsum", avatar: UIImage(named: "rick-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "2w ago", status: .seen, text: "Lorem ipsum",avatar: UIImage(named: "morty-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "dolor sit amet."))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Maecenas et facilisis est, et feugiat diam. Nam ultricies tortor sed mauris tempus lobortis. Aliquam vel vestibulum nulla, eget feugiat libero"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1w ago", status: .seen, text: "Integer lobortis posuere diam, in dignissim purus vestibulum ac."))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1d ago", status: .receive, text: "Maecenas sed mi vehicula, convallis felis at, efficitur turpis. Praesent pulvinar libero."))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Lorem ipsum", avatar: UIImage(named: "rick-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "2w ago", status: .seen, text: "Lorem ipsum",avatar: UIImage(named: "morty-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "dolor sit amet."))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Maecenas et facilisis est, et feugiat diam. Nam ultricies tortor sed mauris tempus lobortis. Aliquam vel vestibulum nulla, eget feugiat libero"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1w ago", status: .seen, text: "Integer lobortis posuere diam, in dignissim purus vestibulum ac."))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1d ago", status: .receive, text: "Maecenas sed mi vehicula, convallis felis at, efficitur turpis. Praesent pulvinar libero."))
        messages.append(ImageMessageModel(condition: messageCondition.receive, date: "", status: nil, avatar: UIImage(named: "morty-avatar"), image: UIImage(named: "rick-avatar")))
        
        messages.append(ImageMessageModel(condition: messageCondition.send, date: "1d ago", status: .seen, avatar: UIImage(named: "rick-avatar"), image: UIImage(named: "morty-avatar")))
        return messages
    }
}
