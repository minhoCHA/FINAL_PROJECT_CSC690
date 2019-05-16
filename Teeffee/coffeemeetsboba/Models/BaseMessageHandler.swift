//
//  BaseMessageHandler.swift
//  coffeemeetsboba
//
//  Created by Gazolboo on 2019/4/23.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class BaseMessageHandler {
    
    private let messageSender: ChatMessageSender
    private let messagesSelector: MessagesSelectorProtocol
    
    init(messageSender: ChatMessageSender, messagesSelector: MessagesSelectorProtocol) {
        self.messageSender = messageSender
        self.messagesSelector = messagesSelector
    }
    func userDidTapOnFailIcon(viewModel: ToffeeMessageViewModelProtocol) {
        print("userDidTapOnFailIcon")
        self.messageSender.sendMessage(viewModel.messageModel)
    }
    
    func userDidTapOnAvatar(viewModel: MessageViewModelProtocol) {
        print("userDidTapOnAvatar")
    }
    
    func userDidTapOnBubble(viewModel: ToffeeMessageViewModelProtocol) {
        print("userDidTapOnBubble")
    }
    
    func userDidBeginLongPressOnBubble(viewModel: ToffeeMessageViewModelProtocol) {
        print("userDidBeginLongPressOnBubble")
    }
    
    func userDidEndLongPressOnBubble(viewModel: ToffeeMessageViewModelProtocol) {
        print("userDidEndLongPressOnBubble")
    }
    
    func userDidSelectMessage(viewModel: ToffeeMessageViewModelProtocol) {
        print("userDidSelectMessage")
        self.messagesSelector.selectMessage(viewModel.messageModel)
    }
    
    func userDidDeselectMessage(viewModel: ToffeeMessageViewModelProtocol) {
        print("userDidDeselectMessage")
        self.messagesSelector.deselectMessage(viewModel.messageModel)
    }
}
