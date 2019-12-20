//
//  ChatControllerProtocols.swift
//  ChatAdaptor
//
//  Created by Sina on 12/18/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ChatControllerDelegates {
    
    func setCells()->Array<ChatCell.Type>
    
    func chatTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func attachmentTapped()
    
    @objc optional func sendTapped()
    
    @objc optional var sendDelegate:Any? {get set}
}
