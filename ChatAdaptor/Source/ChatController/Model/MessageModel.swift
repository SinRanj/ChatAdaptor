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
