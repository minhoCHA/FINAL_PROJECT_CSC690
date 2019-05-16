//
//  ToffeeTextMessageViewModel.swift
//  coffeemeetsboba
//
//  Created by Gazolboo on 2019/4/19.
//  Copyright © 2019 MinhoCha. All rights reserved.
//

import UIKit


import ChattoAdditions


public protocol ToffeeMessageViewModelProtocol {
    var messageModel: ToffeeMessageModelProtocol { get }
}


public class ToffeeTextMessageViewModel: TextMessageViewModel<ToffeeTextMessageModel>, ToffeeMessageViewModelProtocol {
    
    public override init(textMessage: ToffeeTextMessageModel, messageViewModel: MessageViewModelProtocol) {
        super.init(textMessage: textMessage, messageViewModel: messageViewModel)
    }
    
    public var messageModel: ToffeeMessageModelProtocol {
        return self.textMessage
    }
}

public class ToffeeTextMessageViewModelBuilder: ViewModelBuilderProtocol {
    public init() {}
    
    let messageViewModelBuilder = MessageViewModelDefaultBuilder()
    
    public func createViewModel(_ textMessage: ToffeeTextMessageModel) -> ToffeeTextMessageViewModel {
        let messageViewModel = self.messageViewModelBuilder.createMessageViewModel(textMessage)
        let textMessageViewModel = ToffeeTextMessageViewModel(textMessage: textMessage, messageViewModel: messageViewModel)
        textMessageViewModel.avatarImage.value = UIImage(named: "userAvatar")
        return textMessageViewModel
    }
    
    public func canCreateViewModel(fromModel model: Any) -> Bool {
        return model is ToffeeTextMessageModel
    }
}
