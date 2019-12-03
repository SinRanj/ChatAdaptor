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
    
    override func viewDidLoad() {
        initializer()
    }
    
    private func initializer(){
        table = UITableView(frame: CGRect.zero , style: UITableView.Style.plain)
        chatViewHolder = UIView(frame: CGRect.zero)
        self.view.addSubview(table)
        self.view.addSubview(chatViewHolder)
        
        chatViewConfigurations()
        tableConfigurations()
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(self.keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
        
    }
    private func tableConfigurations(){
        table.delegate = self
        table.dataSource = self
        
        view.constraintTopWithAnotherView(view: table, bottomView: chatViewHolder)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "chatCell")
    }
    
    private func chatViewConfigurations(){
        textView = UITextView(frame: CGRect.zero)
        textView.delegate = self
        sendButton = UIButton(frame: CGRect.zero)
        sendButton.setTitle("Send", for: UIControl.State.normal)
        
        chatViewHolder.backgroundColor = UIColor.black
        textView.backgroundColor = UIColor.white
        
        chatViewHolder.addSubview(textView)
        chatViewHolder.addSubview(sendButton)
        
        chatViewHolder.constraintWithCustomWidthAndHeight(view: sendButton, width: 60, height: 60)
        chatViewHolder.constraintLeftWithAnotherView(view: textView, rightView: sendButton)
        view.constraintBottomWithCustomHeight(view: chatViewHolder, heightConst: chatViewHolderHeight)
        chatViewHolderBottomConst = view.constraintFinder(identifier: "bottomConst")

        chatViewHolderHeightConst = chatViewHolder.constraintFinder(identifier: "heightConst")
        originalChatViewHolderHeightConst = chatViewHolderHeightConst.constant
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            UIView.animate(withDuration: 0.4) {
                self.chatViewHolderBottomConst.constant = -keyboardFrame.height
                self.view.layoutIfNeeded()
            }
        }
    }
}


extension ChatViewContoller:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "sss"
        return cell
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
}
