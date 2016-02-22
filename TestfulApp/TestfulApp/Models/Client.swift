//
//  Client.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 13/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class Client: NSObject {

    enum FieldTag : String {
        case Fullname = "fullname"
        case Identifier = "fullName"
        case AvatarPath = "AvatarPath"
        case Messages = "messages"
        case UnreadMessageCount = "unreadMessageCount"
    }
    
    let fullname: String
    let id: Int
    let avatarUrl: NSURL?
    let countUnreadMessages: Int
    let messages: [Message]
    
    init(dictionary : [FieldTag : AnyObject]) {
        self.fullname = dictionary.getValueForKey(.Fullname, withDefaultValue: "")
        self.id = dictionary.getValueForKey(.Identifier, withDefaultValue: 0)
        if let avatarPath = dictionary[.AvatarPath] as? String {
            self.avatarUrl = NSURL(string: avatarPath)
        } else {
            self.avatarUrl = nil
        }
        self.messages = dictionary.getValueForKey(.Messages, withDefaultValue: [Message]())
        self.countUnreadMessages = dictionary.getValueForKey(.UnreadMessageCount, withDefaultValue: 0)
        super.init()
    }
    
    func getLastMessage() -> Message? {
        return self.messages.last
    }
}
