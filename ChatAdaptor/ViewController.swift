//
//  ViewController.swift
//  ChatAdaptor
//
//  Created by Sina on 12/3/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ViewController: ChatViewContoller {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        ChatConfigurations.Colors.colors.chatBackgroundColor = UIColor.white
        //        sendDelegate = self
        chatViewHolderHeight = 50
        initializer()
        mockDataGenerator()
    }
    var sendDelegate: Any?
}
extension ViewController: ChatControllerDelegates{
    func chatTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let message = messages[indexPath.row] as? TextMessageModel {
            if message.condition == .send {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTextSendCell", for: indexPath) as? ChatTextSendCell
                cell!.date = message.date
                cell!.name = message.name
                if let status = message.status {
                    cell!.status = "\(status)"
                }
                cell!.message = message.text
                cell!.hasAvatar = message.avatar
                
                return cell!
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTextReceiveCell", for: indexPath) as? ChatTextReceiveCell
                cell!.date = message.date
                cell!.name = message.name
                cell!.message = message.text
                cell!.hasAvatar = message.avatar
                return cell!
            }
        }
        else if let message = messages[indexPath.row] as? ImageMessageModel {
            if message.condition == .send {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatImageSendCell", for: indexPath) as? ChatImageSendCell
                cell!.date = message.date
                cell!.name = message.name
                if let status = message.status {
                    cell!.status = "\(status)"
                }
                
                cell!.cellImageView.image = message.image
                cell!.hasAvatar = message.avatar
                
                return cell!
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatImageReceiveCell", for: indexPath) as? ChatImageReceiveCell
                cell!.name = message.name
                cell!.date = message.date
                cell!.cellImageView.image = message.image
                cell!.hasAvatar = message.avatar
                return cell!
            }
            
        }
        else if let message = messages[indexPath.row] as? PostMessageModel {
            if message.condition == .send {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatPostSendCell", for: indexPath) as? ChatPostSendCell
                cell!.date = message.date
                cell!.name = message.name
                cell!.posts = message.post
                if let status = message.status {
                    cell!.status = "\(status)"
                }
                cell!.hasAvatar = message.avatar
                
                return cell!
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatImageReceiveCell", for: indexPath) as? ChatImageReceiveCell
                cell!.name = message.name
                cell!.date = message.date
                cell!.hasAvatar = message.avatar
                return cell!
            }
        }
        else {
            return UITableViewCell()
        }
    }
    
    func setCells() -> Array<ChatCell.Type> {
        var cells: Array<ChatCell.Type> = []
        cells.append(ChatTextReceiveCell.self)
        cells.append(ChatTextSendCell.self)
        cells.append(ChatImageReceiveCell.self)
        cells.append(ChatImageSendCell.self)
        cells.append(ChatPostSendCell.self)
        return cells
    }
    func attachmentTapped() {
        
    }
    func sendTapped() {
        
    }
}

