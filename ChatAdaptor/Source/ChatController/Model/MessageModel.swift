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

enum messageAction:String{
    case edit
    case delete
    case reply
    
    var rawValue: String {
        switch self {
        case .edit: return "Edit"
        case .delete: return "Delete"
        case .reply: return "Reply"
        }
    }
}
protocol MessageModel {
    
    /// Condition of message(Send or receive)
    var condition:messageCondition! {get set}
    
    /// Date of message which shows in bottom right of bubble message.
    var date:String? {get set}
    
    /// Status of message(sending, send, receive, seen)
    var status:messageStatus? {get set}
    
    /// Avatar image of user
    var avatar:UIImage?{get set}
    
    /// Name or username of user.
    var name:String! {get set}
    
    /// Functionality of action(Edit, reply, delete).
    func actionsForType()->[messageAction]
}

extension MessageModel {
    
    /// Create a mock data and return an array of messages.
    func mockData()-> Array<MessageModel>{
        var messages:Array<MessageModel> = []
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Lorem ipsum", avatar: UIImage(named: "rick-avatar"), name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "2w ago", status: .seen, text: "Lorem ipsum",avatar: UIImage(named: "morty-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "dolor sit amet.", name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Maecenas et facilisis est, et feugiat diam. Nam ultricies tortor sed mauris tempus lobortis. Aliquam vel vestibulum nulla, eget feugiat libero", name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1w ago", status: .seen, text: "Integer lobortis posuere diam, in dignissim purus vestibulum ac."))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1d ago", status: .receive, text: "Maecenas sed mi vehicula, convallis felis at, efficitur turpis. Praesent pulvinar libero."))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Lorem ipsum", avatar: UIImage(named: "rick-avatar"), name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "2w ago", status: .seen, text: "Lorem ipsum",avatar: UIImage(named: "morty-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "dolor sit amet.", name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Maecenas et facilisis est, et feugiat diam. Nam ultricies tortor sed mauris tempus lobortis. Aliquam vel vestibulum nulla, eget feugiat libero", name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1w ago", status: .seen, text: "Integer lobortis posuere diam, in dignissim purus vestibulum ac."))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1d ago", status: .receive, text: "Maecenas sed mi vehicula, convallis felis at, efficitur turpis. Praesent pulvinar libero.", name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Lorem ipsum", avatar: UIImage(named: "rick-avatar"), name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "2w ago", status: .seen, text: "Lorem ipsum",avatar: UIImage(named: "morty-avatar")))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "dolor sit amet.", name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.receive, date: nil, status: nil, text: "Maecenas et facilisis est, et feugiat diam. Nam ultricies tortor sed mauris tempus lobortis. Aliquam vel vestibulum nulla, eget feugiat libero", name: "Rick"))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1w ago", status: .seen, text: "Integer lobortis posuere diam, in dignissim purus vestibulum ac."))
        messages.append(TextMessageModel(condition: messageCondition.send, date: "1d ago", status: .receive, text: "Maecenas sed mi vehicula, convallis felis at, efficitur turpis. Praesent pulvinar libero.", name: "Rick"))
        messages.append(ImageMessageModel(condition: messageCondition.receive, date: "", status: nil, avatar: UIImage(named: "morty-avatar"), image: UIImage(named: "rick-avatar"), name: "Rick"))
        
        messages.append(ImageMessageModel(condition: messageCondition.send, date: "1d ago", status: .seen, avatar: UIImage(named: "rick-avatar"), image: UIImage(named: "morty-avatar")))
        
        var postModel = PostModel(image: UIImage(named: "morty-avatar"), vote: 2, isPrivate: false)
        var postModel2 = PostModel(image: UIImage(named: "rick-avatar"), vote: nil, isPrivate: true)
        
        let postMessageModel = PostMessageModel(condition: messageCondition.send, date: "1d ago", status: .seen, avatar: UIImage(named: "rick-avatar"), post: [postModel,postModel2])
        
        messages.append(postMessageModel)
        
        postModel = PostModel(image: UIImage(named: "morty-avatar"), vote: nil, isPrivate: false)
        postModel2 = PostModel(image: UIImage(named: "rick-avatar"), vote: 2, isPrivate: true)
        
        let postMessageModel2 = PostMessageModel(condition: messageCondition.send, date: "1d ago", status: .seen, avatar: UIImage(named: "rick-avatar"), post: [postModel,postModel2])
        messages.append(postMessageModel2)

        postModel = PostModel(image: UIImage(named: "rick-avatar"), vote: 10, isPrivate: true)
        let postMessageModel3 = PostMessageModel(condition: messageCondition.send, date: "1d ago", status: .seen, avatar: UIImage(named: "rick-avatar"), post: [postModel])
        messages.append(postMessageModel3)
        return messages
    }
}
