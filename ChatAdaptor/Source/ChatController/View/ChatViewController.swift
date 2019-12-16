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
    private var replyView:ReplyView!
    
    private var oldTextViewSize:CGSize = CGSize(width: 0, height: 30)
    private var originalChatViewHolderHeightConst:CGFloat!
    
    var chatViewHolderHeight:CGFloat = 60
    var textView:UITextView!
    var sendButton:UIButton!
    
    private var chatViewHolderBottomConst:NSLayoutConstraint!
    private var chatViewHolderHeightConst:NSLayoutConstraint!
    private var tapTable: UITapGestureRecognizer!
    private var spotlight:SpotlightView!
    private var keyboardIsVisible = false
    var messages: Array<MessageModel> = []
    private var isReplyViewShowing = false
    
    private var replyCell:ChatCell?
    private var messageIndexPath:IndexPath?
    private var messageAction:messageAction?
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
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
        table.register(ChatTextReceiveCell.self, forCellReuseIdentifier: "receiveTextCell")
        table.register(ChatTextSendCell.self, forCellReuseIdentifier: "sendTextCell")
        table.register(ChatImageReceiveCell.self, forCellReuseIdentifier: "receiveImageCell")
        table.register(ChatImageSendCell.self, forCellReuseIdentifier: "sendImageCell")
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        spotlight = SpotlightView(view: view)
    }
    
    private func chatViewConfigurations(){
        chatViewHolder.backgroundColor = ChatConfigurations.Colors.sharedInstance.chatViewHolderBackGroundColor
        textView = UITextView(frame: CGRect.zero)
        textView.backgroundColor = ChatConfigurations.Colors.sharedInstance.chatViewHolderBackGroundColor
        
        textView.delegate = self
        textView.text = "Message..."
        textView.textColor = UIColor.lightGray
        
        sendButton = UIButton(frame: CGRect.zero)
        sendButton.setTitle("Send", for: UIControl.State.normal)
        sendButton.setTitleColor(UIColor.black, for: .normal)
        sendButton.addTarget(self, action: #selector(didTapSend), for: UIControl.Event.touchUpInside)
        
        chatViewHolder.addSubview(textView)
        chatViewHolder.addSubview(sendButton)
        chatViewHolder.identifier = "chatViewHolder"
        chatViewHolder.constraintWithCustomWidthAndHeight(view: sendButton, width: 60, height: 60)
        chatViewHolder.constraintLeftWithAnotherView(view: textView, rightView: sendButton)
        view.constraintBottomWithCustomHeight(view: chatViewHolder, heightConst: chatViewHolderHeight)
        chatViewHolderBottomConst = view.constraintFinder(identifier: "chatViewHolder bottomConst")

        chatViewHolderHeightConst = chatViewHolder.constraintFinder(identifier: "heightConst")
        originalChatViewHolderHeightConst = chatViewHolderHeightConst.constant
    }
    private func addReplyView(){
        if replyView == nil {
            replyView = ReplyView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0), closeAction: {
                DispatchQueue.main.async {
                    self.closeReplyView()
                }
            })
            view.addSubview(replyView)
        }
        self.sendButton.setImage(nil, for: UIControl.State.normal)
        self.sendButton.setTitle("Send", for: UIControl.State.normal)
        
        isReplyViewShowing = true
        if let cell = replyCell as? ChatTextReceiveCell {
            replyView.message = cell.message
            replyView.name = cell.name
        }
        else if let cell = replyCell as? ChatTextSendCell{
            replyView.message = cell.message
            replyView.name = "You"
            if messageAction == .edit{
                sendButton.setImage(UIImage(named: "checked"), for: UIControl.State.normal)
                sendButton.imageView?.contentMode = .scaleAspectFit
            }
            
        }
        else if let cell = replyCell as? ChatImageReceiveCell{
            replyView.message = "🌃 Photo"
            replyView.name = cell.name
        }
        else if let _ = replyCell as? ChatImageSendCell{
            replyView.message = "🌃 Photo"
            replyView.name = "You"
        }
        view.bringSubviewToFront(chatViewHolder)
        replyView.identifier = "replyView"
        replyViewConfigurations()
    }
    private func replyViewConfigurations(){
        view.constraintBottomWithCustomHeight(view: replyView, heightConst: 60,secondView: chatViewHolder)
        self.view.layoutIfNeeded()
        let bottomConst = view.constraintFinder(identifier: "replyView bottomConst")
        if let bottomConst = bottomConst {
            UIView.animate(withDuration: 0.2) {
                bottomConst.constant = 0
                self.view.layoutIfNeeded()
                self.chatViewHolder.removeLine()
            }
        }
    }
    @objc func closeReplyView(){
        messageAction = nil
        messageIndexPath = nil
        replyCell = nil
        self.sendButton.setImage(nil, for: UIControl.State.normal)
        self.sendButton.setTitle("Send", for: UIControl.State.normal)
        let bottomConst = view.constraintFinder(identifier: "replyView bottomConst")
        if let bottomConst = bottomConst {
            UIView.animate(withDuration: 0.2, animations: {
                bottomConst.constant = 60
                self.view.layoutIfNeeded()
                self.chatViewHolder.removeLine()
            }) { (_) in
                self.view.layoutIfNeeded()
                self.replyView.removeFromSuperview()
                self.replyView = nil
                self.isReplyViewShowing = false
            }
        }
    }
    func layouts(shouldDraw:Bool=true){
        chatViewHolder.removeLine()
        if shouldDraw {
            chatViewHolder.drawLine(fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: UIScreen.main.bounds.size.width, y: 0))
        }
        
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
            if messageAction != nil {
                if messageAction == .edit {
                    let message = messages[messageIndexPath!.row]
                    table.beginUpdates()
                    messages[messageIndexPath!.row] = TextMessageModel(condition: message.condition, date: "edited now", status: message.status, text: textView.text, avatar: message.avatar, name: message.name)
                    table.reloadRows(at: [messageIndexPath!], with: .automatic)
                    table.endUpdates()
                    closeReplyView()
                }
            }
            else {
                messages.append(TextMessageModel(condition: .send, date: "now", status: .send, text: textView.text, avatar: nil))
                updateMessages()
            }
            textView.text = ""
            chatViewHolderHeightConst.constant = originalChatViewHolderHeightConst
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tapTable = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapTable.name = "tapTable"
            table.addGestureRecognizer(tapTable)
            keyboardIsVisible = true
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
    @objc func keyboardDidHide(notification: NSNotification) {
        keyboardIsVisible = false
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
                    self.textView.resignFirstResponder()
                    if keyboardIsVisible {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
                            self.showSpotLight(indexPath: indexPath)
                        }
                    }
                    else {
                        self.showSpotLight(indexPath: indexPath)
                    }
                }
                
            }
        }
    }
    private func showSpotLight(indexPath:IndexPath){
        let rectOfCellInTableView = self.table.rectForRow(at: indexPath)
        guard let cell = table.cellForRow(at: indexPath) as? ChatCell else { return  }
        
        let rectOfCellInSuperview = self.table.convert(rectOfCellInTableView, to: self.table.superview)
        self.spotlight.delegate = self
        
        self.spotlight.addSpotlightToView(cell: cell,rect: rectOfCellInSuperview,messageActions: messages[indexPath.row].actionsForType(), indexPath: indexPath)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layouts(shouldDraw: !isReplyViewShowing)
    }
}

extension ChatViewContoller:SpotlightDelegate{
    
    func didSelectItem(action: messageAction, indexPath: IndexPath) {
        messageAction = action
        messageIndexPath = indexPath
        switch action {
        case .delete:
            table.beginUpdates()
            messages.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            table.endUpdates()
        case .reply:
            replyCell = table.cellForRow(at: indexPath) as? ChatCell
            addReplyView()
        case .edit:
            replyCell = table.cellForRow(at: indexPath) as? ChatCell
            addReplyView()
        }
    }

}

extension ChatViewContoller:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let message = messages[indexPath.row] as? TextMessageModel {
            if message.condition == .send {
                let cell = tableView.dequeueReusableCell(withIdentifier: "sendTextCell", for: indexPath) as? ChatTextSendCell
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "receiveTextCell", for: indexPath) as? ChatTextReceiveCell
                cell!.date = message.date
                cell!.name = message.name
                cell!.message = message.text
                cell!.hasAvatar = message.avatar
                return cell!
            }
        }
        else if let message = messages[indexPath.row] as? ImageMessageModel {
            if message.condition == .send {
                let cell = tableView.dequeueReusableCell(withIdentifier: "sendImageCell", for: indexPath) as? ChatImageSendCell
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "receiveImageCell", for: indexPath) as? ChatImageReceiveCell
                cell!.name = message.name
                cell!.date = message.date
                cell!.cellImageView.image = message.image
                cell!.hasAvatar = message.avatar
                return cell!
            }

        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiveTextCell", for: indexPath) as? ChatTextReceiveCell
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
                UIView.animate(withDuration: 0.2) {
                    self.chatViewHolderHeightConst.constant += 10
                    self.view.layoutIfNeeded()
                }

            }
        }
        else if newFrame.size.height < oldTextViewSize.height{
            if chatViewHolderHeightConst.constant > originalChatViewHolderHeightConst {
                if textView.text == "" {
                    UIView.animate(withDuration: 0.2) {
                        self.chatViewHolderHeightConst.constant = self.originalChatViewHolderHeightConst
                        self.view.layoutIfNeeded()
                    }
                }
                else {
                    UIView.animate(withDuration: 0.2) {
                        self.chatViewHolderHeightConst.constant -= 10
                        self.view.layoutIfNeeded()
                    }
                    
                }
                
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
