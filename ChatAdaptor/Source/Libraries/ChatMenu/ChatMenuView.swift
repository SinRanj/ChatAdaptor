//
//  ChatMenuView.swift
//  ChatAdaptor
//
//  Created by Sina on 12/9/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import Foundation
import UIKit


/// MenuItem available variables
struct ChatMenuItem{
    var title:String!
}

/// MenuDelegate which contains didSelectItem for sending selectedItem's index and title to delegate.
protocol ChatMenuDelegate:AnyObject {
    func didSelectItem(index:Int,title:String)
}
class ChatMenu:UIView,UITableViewDataSource,UITableViewDelegate {
    
    /// Menue's frame
    private var _frame :CGRect!
    
    
    /// Menu's table
    private var _table : UITableView!
    
    /// Menu's itmes
    private var _items = [ChatMenuItem]()
    
    /// Delegate of menu
    weak var delegate:ChatMenuDelegate?
    
    /// Menu's current state
    ///
    /// - open: If menu is open
    /// - close: If menu is closed
    enum menuState {
        case open
        case close
    }
    
     /// Current state of menu
     var state = menuState.close
    
    
    /// This init create's and add's MenuView to given viewController's navigationBar.
    ///
    /// - Parameters:
    ///   - viewController: A viewController to add menu to it's navigation bar.
    ///   - items: Items of menu
    init(frame:CGRect,items:[ChatMenuItem]){
        
        super.init(frame: frame)
        self.alpha = 0
        _items = items
        let rootViewController = UIApplication.shared.windows.first
        rootViewController?.addSubview(self)
        configs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// This function configure menu
    private func configs(){
        self.backgroundColor = UIColor.black
        self.cornerRadius()
        configTable()
    }
    
    /// This function configure menu's table.
    private func configTable(){
        _table = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height) , style: UITableView.Style.plain)
        _table.delegate = self
        _table.dataSource = self
        self.addSubview(_table)
        _table.estimatedRowHeight = self.frame.height/2
        _table.isScrollEnabled = false
        _table.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
    }
    
    /// This function add's shadow to menu view.
    func show(){
        if state == .close {
            open()
        }
        else {
            close()
        }
    }
    
    /// This function open's up menu with appear animation
    private func open(){
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.alpha = 1
        }) { (success) in
            self.state = .open
        }
    }
    
    /// This function close's menu with disolve animation
    private func close(){
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.alpha = 0
        }) { (success) in
            self.state = .close
        }
    }
    
    /// Number of sections in table
    ///
    /// - Parameter tableView: UITableView
    /// - Returns: Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Number of rows in section of a table which is number of items in menu
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: SectionId
    /// - Returns: Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _items.count
    }
    
    /// Each cell of a table is inherited from 'MenuCell' with 'cell' identifier
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    /// - Returns: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _table.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = _items[indexPath.row].title
        return cell
    }
    
    /// Height for rows at indexPath which depends on number of items in menu.
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    /// - Returns: Height of each cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.height/CGFloat(_items.count)
    }
    
    /// Checks if user picked an item in menu and send its value via delegate.
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: IndexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(index: indexPath.row, title: _items[indexPath.row].title)
    }
    
}

