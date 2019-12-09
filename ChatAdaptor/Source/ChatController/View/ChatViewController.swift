//
//  ChatController.swift
//  Chat
//
//  Created by Sina on 12/3/19.
//  Copyright © 2019 Sina. All rights reserved.
//

import UIKit

class ChatViewContoller: UIViewController {
    private var table : UITableView!
    private var chatViewHolder:UIView!
    
    private var oldTextViewSize:CGSize = CGSize(width: 0, height: 30)
    private var originalChatViewHolderHeightConst:CGFloat!
    
    var chatViewHolderHeight:CGFloat = 60
    var textView:UITextView!
    var sendButton:UIButton!
    
    private var chatViewHolderBottomConst:NSLayoutConstraint!
    private var chatViewHolderHeightConst:NSLayoutConstraint!
    private var tapTable: UITapGestureRecognizer!
    private var spotlight:SpotlightView!
    
    var messages = [TextMessageModel]()

    override func viewDidLoad() {
        initializer()
        mockDataGenerator()
    }
    
    private func initializer(){
        table = UITableView(frame: CGRect.zero , style: UITableView.Style.plain)
        chatViewHolder = UIView(frame: CGRect.zero)
        self.view.addSubview(table)
        self.view.addSubview(chatViewHolder)
        table.separatorStyle = .none
        
        chatViewConfigurations()
        tableConfigurations()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        
    }
    
    private func mockDataGenerator(){
        let message = TextMessageModel()
        messages = message.mockData()
        table.reloadData()
    }
    
    private func tableConfigurations(){
        table.delegate = self
        table.dataSource = self
        
        view.constraintTopWithAnotherView(view: table, bottomView: chatViewHolder)
        table.register(ChatReceiveCell.self, forCellReuseIdentifier: "receiveCell")
        table.register(ChatSendCell.self, forCellReuseIdentifier: "sendCell")
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        spotlight = SpotlightView(view: view)
    }
    
    private func chatViewConfigurations(){
        textView = UITextView(frame: CGRect.zero)
        textView.delegate = self
        textView.text = "Message..."
        textView.textColor = UIColor.lightGray
        
        sendButton = UIButton(frame: CGRect.zero)
        sendButton.setTitle("Send", for: UIControl.State.normal)
        sendButton.setTitleColor(UIColor.black, for: .normal)
        sendButton.addTarget(self, action: #selector(didTapSend), for: UIControl.Event.touchUpInside)
        
        chatViewHolder.addSubview(textView)
        chatViewHolder.addSubview(sendButton)
        
        chatViewHolder.constraintWithCustomWidthAndHeight(view: sendButton, width: 60, height: 60)
        chatViewHolder.constraintLeftWithAnotherView(view: textView, rightView: sendButton)
        view.constraintBottomWithCustomHeight(view: chatViewHolder, heightConst: chatViewHolderHeight)
        chatViewHolderBottomConst = view.constraintFinder(identifier: "bottomConst")

        chatViewHolderHeightConst = chatViewHolder.constraintFinder(identifier: "heightConst")
        originalChatViewHolderHeightConst = chatViewHolderHeightConst.constant
    }
    
    func layouts(){
        chatViewHolder.removeLine()
        chatViewHolder.drawLine(fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: UIScreen.main.bounds.size.width, y: 0))
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func updateMessages(){
        table.reloadData()
        table.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
        
    }
    @objc private func didTapSend(){
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines) != "" && textView.textColor != UIColor.lightGray {
            messages.append(TextMessageModel(condition: .send, date: "now", status: .send, text: textView.text, avatar: nil))
            textView.text = ""
            updateMessages()
            chatViewHolderHeightConst.constant = originalChatViewHolderHeightConst
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tapTable = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapTable.name = "tapTable"
            table.addGestureRecognizer(tapTable)
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func dismissKeyboard(){
        textView.resignFirstResponder()
        if let recognizers = self.table.gestureRecognizers {
          for recognizer in recognizers {

            if recognizer.name == self.tapTable.name {
                self.table.removeGestureRecognizer(recognizer)
            }
          }
        }
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {

        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.table)
            if let indexPath = table.indexPathForRow(at: touchPoint) {
                if spotlight.isApear == false {
                    guard let cell = table.cellForRow(at: indexPath) as? ChatCell else { return  }
                    spotlight.addSpotlightToView(cell: cell)
                }
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
          layouts()
    }
}


extension ChatViewContoller:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.condition == .send {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendCell", for: indexPath) as? ChatSendCell
            cell!.date = message.date
            if let status = message.status {
                cell!.status = "\(status)"
            }
            cell!.message = message.text
            cell!.hasAvatar = message.avatar
            
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiveCell", for: indexPath) as? ChatReceiveCell
            cell!.date = message.date
            cell!.message = message.text
            cell!.hasAvatar = message.avatar
            return cell!
        }
    }
}
extension ChatViewContoller:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize.init(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame = textView.frame
        newFrame.size = CGSize.init(width: CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), height: newSize.height)
        if newFrame.size.height > oldTextViewSize.height {
            if newFrame.size.height <= 72 {
                chatViewHolderHeightConst.constant += 10
                view.layoutIfNeeded()
            }
        }
        else if newFrame.size.height < oldTextViewSize.height{
            if chatViewHolderHeightConst.constant > originalChatViewHolderHeightConst {
                if textView.text == "" {
                    chatViewHolderHeightConst.constant = originalChatViewHolderHeightConst
                }
                else {
                    chatViewHolderHeightConst.constant -= 10
                }
                view.layoutIfNeeded()
            }
        }
        oldTextViewSize = newFrame.size
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message..."
            textView.textColor = UIColor.lightGray
        }
    }
}
