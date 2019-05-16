//
//  ToffeeTextMessageModel.swift
//  coffeemeetsboba
//
//  Created by Gazolboo on 2019/4/19.
//  Copyright © 2019 MinhoCha. All rights reserved.
//
import Foundation
import ChattoAdditions

public class ToffeeTextMessageModel: TextMessageModel<MessageModel>, ToffeeMessageModelProtocol {
    public override init(messageModel: MessageModel, text: String) {
        super.init(messageModel: messageModel, text: text)
    }
    
    public var status: MessageStatus {
        get {
            return self._messageModel.status
        }
        set {
            self._messageModel.status = newValue
        }
    }
}
