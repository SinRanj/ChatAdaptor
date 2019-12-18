//
//  ChatControllerProtocols.swift
//  ChatAdaptor
//
//  Created by Sina on 12/18/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit

protocol ChatControllerDelegates {
    func setCells()->Array<ChatCell.Type>
    func chatTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
