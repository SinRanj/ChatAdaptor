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
    
    private var oldTextViewSize:CGSize = CGSize(width: 0, height: 30.5)
    private var originalChatViewHolderHeightConst:CGFloat!
    
    var chatViewHolderHeight:CGFloat = 60
    var textView:UITextView!
    var sendButton:UIButton!
    var attachmentButton:UIButton!
    
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
    private var cells: Array<ChatCell.Type>? = []
    weak var delegate:ChatControllerDelegates?
    private var scrollButton = UIButton()
    
    var topMargin:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initializer(){
        table = UITableView(frame: CGRect.zero , style: UITableView.Style.plain)
        
        table.backgroundColor = ChatConfigurations.Colors.colors.chatBackgroundColor
        if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
            table.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
            table.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: table.bounds.size.width - 10)
        }
        
        chatViewHolder = UIView(frame: CGRect.zero)
        self.view.addSubview(table)
        self.view.addSubview(chatViewHolder)
        table.separatorStyle = .none
        
        chatViewConfigurations()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        cells = delegate?.setCells()
        tableConfigurations()
        
        view.addSubview(scrollButton)
        scrollButton.setImage(ChatConfigurations.Icons.icons.downIcon, for: UIControl.State.normal)
        
        scrollButton.alpha = 0.8
        scrollButton.addTarget(self, action: #selector(scrollToBottom), for: UIControl.Event.touchUpInside)
        scrollButton.isHidden = true
        view.constraintCustom(view: scrollButton, rightConst: -20, bottomConst: -80, widthConst: 40, heightConst: 40)
        
    }
    
    func mockDataGenerator(){
        let message = TextMessageModel()
        messages = message.mockData()
        if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
            messages.reverse()
        }
        updateMessages()
    }
    
    private func tableConfigurations(){
        guard let cells = cells else {
            return
        }
        
        table.delegate = self
        table.dataSource = self
        
        view.constraintCustom(view: table, leftConst: 0, rightConst: 0, bottomConst: 0, bottomView: chatViewHolder, bottomViewAttribute: NSLayoutConstraint.Attribute.top, bottomSelfAttribute: NSLayoutConstraint.Attribute.bottom, topConst: topMargin+view.topPadding)
        for i in cells {
            table.register(i.self, forCellReuseIdentifier: "\(i.self)")
        }

        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        spotlight = SpotlightView(view: view)
    }
    
    private func chatViewConfigurations(){
        chatViewHolder.backgroundColor = ChatConfigurations.Colors.colors.chatViewHolderBackGroundColor
        textView = UITextView(frame: CGRect.zero)
        textView.backgroundColor = ChatConfigurations.Colors.colors.chatViewHolderBackGroundColor
        
        textView.delegate = self
        textView.text = "Message..."
        textView.textColor = UIColor.lightGray
        textView.font = ChatConfigurations.Fonts.fonts.messageFont
        
        sendButton = UIButton(frame: CGRect.zero)
        sendButton.setTitle("Send", for: UIControl.State.normal)
        sendButton.setImage(ChatConfigurations.Icons.icons.sendButtonIcon, for: UIControl.State.normal)
        sendButton.setTitleColor(UIColor.black, for: .normal)
        sendButton.addTarget(self, action: #selector(didTapSend), for: UIControl.Event.touchUpInside)
        
        attachmentButton = UIButton(frame: CGRect.zero)
        attachmentButton.setImage(ChatConfigurations.Icons.icons.attachmentIcon, for: UIControl.State.normal)
        attachmentButton.imageView?.contentMode = .scaleAspectFit
        attachmentButton.addTarget(self, action: #selector(didTapAttachment), for: UIControl.Event.touchUpInside)
        
        chatViewHolder.addSubview(textView)
        chatViewHolder.addSubview(sendButton)
        chatViewHolder.addSubview(attachmentButton)
        
        chatViewHolder.identifier = "chatViewHolder"
        chatViewHolder.constraintCustom(view: attachmentButton,leftConst: 8, bottomConst: -11-view.bottomPadding,widthConst: 30,heightConst: 30)
        
        
        chatViewHolder.constraintCustom(view: sendButton, rightConst: -8, bottomConst: -11-view.bottomPadding,  widthConst: 60, heightConst: 30)
        chatViewHolder.constraintCustom(view: textView, leftConst: 8, leftView: attachmentButton, leftViewAttribute: NSLayoutConstraint.Attribute.right, leftSelfAttribute: NSLayoutConstraint.Attribute.left, rightConst: -8, rightView: sendButton, rightViewAttribute: NSLayoutConstraint.Attribute.left, rightSelfAttribute: NSLayoutConstraint.Attribute.right, bottomConst: -8-view.bottomPadding, topConst: 8)
        
//        view.constraintBottomWithCustomHeight(view: chatViewHolder, heightConst: chatViewHolderHeight+self.view.bottomPadding)
        
        view.constraintCustom(view: chatViewHolder, leftConst: 0, rightConst: 0, bottomConst: 0, heightConst: chatViewHolderHeight+self.view.bottomPadding)
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
        sendButton.setImage(ChatConfigurations.Icons.icons.sendButtonIcon, for: UIControl.State.normal)
        
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
    @objc func scrollToBottom(){
        updateMessages()
    }
    @objc func closeReplyView(){
        messageAction = nil
        messageIndexPath = nil
        replyCell = nil
        self.sendButton.setImage(nil, for: UIControl.State.normal)
        self.sendButton.setTitle("Send", for: UIControl.State.normal)
        sendButton.setImage(ChatConfigurations.Icons.icons.sendButtonIcon, for: UIControl.State.normal)
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
    
    func updateMessages(){
        table.reloadData()
        var position = UITableView.ScrollPosition.bottom
        var row = messages.count-1
        if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
            position = UITableView.ScrollPosition.top
            row = 0
        }
        table.scrollToRow(at: IndexPath(row: row , section: 0), at: position, animated: true)
        
    }
    
    func didReceiveMessage(array:Array<MessageModel>){
        for i in array {
            if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
                messages.insert(i, at: 0)
            }
            else {
                messages.append(i)
            }
        }
        updateMessages()

    }
    
    func didReceiveMessage(message:MessageModel){
        if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
            messages.insert(message, at: 0)
        }
        else {
            messages.append(message)
        }
    }
    
    @objc private func didTapSend(){
        if delegate?.sendDelegate is ChatViewContoller {
            delegate?.sendTapped?()
            return
        }
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
                if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
                    messages.insert(TextMessageModel(condition: .send, date: "now", status: .send, text: textView.text, avatar: nil), at: 0)
                }
                else {
                    messages.append(TextMessageModel(condition: .send, date: "now", status: .send, text: textView.text, avatar: nil))
                }
                updateMessages()
            }
            textView.text = ""
            chatViewHolderHeightConst.constant = originalChatViewHolderHeightConst
        }
    }
    
    @objc private func didTapAttachment(){
        delegate?.attachmentTapped()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tapTable = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapTable.name = "tapTable"
            table.addGestureRecognizer(tapTable)
            keyboardIsVisible = true
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height-(self.view.bottomPadding)
                self.table.layoutIfNeeded()
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
        textViewDidEndEditing(textView)
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
        
        return delegate?.chatTableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var firstRow = messages.count-1
        if ChatConfigurations.MessageConfigurations.messageConfigurations.shouldFlip {
            firstRow = 0
        }
        if let rows = table.indexPathsForVisibleRows {
            let x = rows.contains(IndexPath(row: firstRow, section: 0))
            if x {
                scrollButton.isHidden = true
            }
            else {
                scrollButton.isHidden = false
            }
        }
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
            if newFrame.size.height <= 82 {
                UIView.animate(withDuration: 0.2) {
                    self.chatViewHolderHeightConst.constant += 10
                    self.view.layoutIfNeeded()
                }
            }
            else {
                UIView.animate(withDuration: 0.2) {
                    self.chatViewHolderHeightConst.constant = 80
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
            textView.textColor = ChatConfigurations.Colors.colors.textColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message..."
            textView.textColor = UIColor.lightGray
        }
    }
    
}
