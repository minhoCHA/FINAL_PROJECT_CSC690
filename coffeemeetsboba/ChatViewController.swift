//
//  ChatViewController.swift
//  coffeemeetsboba
//
//  Created by MinhoCha on 2019/4/8.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import Chatto
import ChattoAdditions

class ChatViewController: BaseChatViewController, ChatServiceDelegate {

    var peer : MCPeerID?
    var chatService: ChatService?
    var messageSender: ChatMessageSender!
    let messagesSelector = BaseMessagesSelector()
    var chatInputView : UIView?
    var isLeftChatRoomInitiated : Bool = false
    
    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender, messagesSelector: self.messagesSelector)
    }()
    
    var dataSource: ChatDataSource! {
        didSet {
            self.chatDataSource = self.dataSource
            self.messageSender = self.dataSource.messageSender
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatService!.delegate = self
        // Do any additional setup after loading the view.
//        self.messagesSelector.delegate = self
        
        self.chatItemsDecorator = ToffeeChatItemsDecorator(messagesSelector: self.messagesSelector)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if self.isMovingFromParent {
            self.isLeftChatRoomInitiated = true
            self.chatService?.session.disconnect()
        }
    }
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        self.chatInputView = chatInputView
        return self.chatInputView!
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
//        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            // Your handling logic
            if (self?.chatService?.sendData(text: text, toPeer: self!.peer!))!{
                self?.dataSource.addTextMessage(text, success: true)
            }
            else{
                print("Could not send data")
                self?.dataSource.addTextMessage(text, success : false)
            }
            }
        return item
    }
    
//    private func createPhotoInputItem() -> PhotosChatInputItem {
//        let item = PhotosChatInputItem(presentingController: self)
//        item.photoInputHandler = { [weak self] image in
//            // Your handling logic
//        }
//        return item
//    }
    
     override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: ToffeeTextMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()

        
        return [
            ToffeeTextMessageModel.chatItemType: [textMessagePresenter]
        ]
    }
    func receiveMessage(text: String) {
        self.dataSource.addIncomingTextMessage(text)
    }
    
    func foundPeer() {
        
    }
    
    func lostPeer() {
        
    }
    
    func invitationWasReceived(peerID: MCPeerID) {
        
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        
    }
    
    func connectionFailed() {
        if !isLeftChatRoomInitiated{
            OperationQueue.main.addOperation { () -> Void in
                self.chatInputView?.isUserInteractionEnabled = false
                let alert = UIAlertController(title: "", message: "\(self.peer!.displayName) left chat room.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
