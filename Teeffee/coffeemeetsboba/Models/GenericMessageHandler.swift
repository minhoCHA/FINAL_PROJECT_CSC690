//
//  GenericMessageHandler.swift
//  coffeemeetsboba
//
//  Created by Gazolboo on 2019/4/23.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import ChattoAdditions

final class GenericMessageHandler<ViewModel: ToffeeMessageViewModelProtocol & MessageViewModelProtocol>: BaseMessageInteractionHandlerProtocol {
    
    private let baseHandler: BaseMessageHandler
    
    init(baseHandler: BaseMessageHandler) {
        self.baseHandler = baseHandler
    }
    
    func userDidTapOnFailIcon(viewModel: ViewModel, failIconView: UIView) {
        self.baseHandler.userDidTapOnFailIcon(viewModel: viewModel)
    }
    
    func userDidTapOnAvatar(viewModel: ViewModel) {
        self.baseHandler.userDidTapOnAvatar(viewModel: viewModel)
    }
    
    func userDidTapOnBubble(viewModel: ViewModel) {
        self.baseHandler.userDidTapOnBubble(viewModel: viewModel)
    }
    
    func userDidBeginLongPressOnBubble(viewModel: ViewModel) {
        self.baseHandler.userDidBeginLongPressOnBubble(viewModel: viewModel)
    }
    
    func userDidEndLongPressOnBubble(viewModel: ViewModel) {
        self.baseHandler.userDidEndLongPressOnBubble(viewModel: viewModel)
    }
    
    func userDidSelectMessage(viewModel: ViewModel) {
        self.baseHandler.userDidSelectMessage(viewModel: viewModel)
    }
    
    func userDidDeselectMessage(viewModel: ViewModel) {
        self.baseHandler.userDidDeselectMessage(viewModel: viewModel)
    }
}
