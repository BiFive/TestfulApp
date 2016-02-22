//
//  PlistClientsProvider.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 16/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class PlistClientsProvider: AbstractClientsProvider {

    enum PlistKeys : String {
        case Fullname = "fullname"
        case Identifier = "identifier"
        case AvatarURL = "avatarURL"
        case MessageText = "message"
        case SendingDate = "sendingDate"
        case UnreadMessageCount = "unreadMessagesCount"
    }
    
    static let keysAndClientTags = [
        (PlistKeys.Fullname.rawValue, Client.FieldTag.Fullname),
        (PlistKeys.Identifier.rawValue, Client.FieldTag.Identifier),
        (PlistKeys.AvatarURL.rawValue, Client.FieldTag.AvatarPath),
        (PlistKeys.UnreadMessageCount.rawValue, Client.FieldTag.UnreadMessageCount)
    ]
    
    static let keysAndMessageTags = [
        (PlistKeys.MessageText.rawValue, Message.FieldTag.Text),
        (PlistKeys.SendingDate.rawValue, Message.FieldTag.SendingDate)
    ]
    
    let plistURL: NSURL
    
    init(plistURL: NSURL) {
        self.plistURL = plistURL
        super.init()
    }
    
    override func fetchClients(completitionHandler: FetchComplitionHanlder) {
        guard let clientsData = NSArray(contentsOfURL: self.plistURL) else {
            completitionHandler(clients: nil, error: NSError(domain: "PlistClientsProvider", code: 0, userInfo: nil))
            return
        }
        
        var clients = [Client]()
        for clientDictionary in clientsData {
            if let clientDictionary =  clientDictionary as? [String : AnyObject] {
                let client = self.buildClientModel(clientDictionary)
                clients.append(client)
            }
        }
        completitionHandler(clients: clients, error: nil)
    }
    
    private func buildClientModel(dictionary: [String : AnyObject]) -> Client {
        var clientDictionary = Dictionary<Client.FieldTag, AnyObject>()
        for (key, tag) in PlistClientsProvider.keysAndClientTags {
            if let value = dictionary[key] {
                clientDictionary[tag] = value
            }
        }
        
        let message = self.buildMessageModel(dictionary)
        clientDictionary[Client.FieldTag.Messages] = [message]
        
        return Client(dictionary: clientDictionary)
    }
    
    private func buildMessageModel(dictionary: [String : AnyObject]) -> Message {
        var messageDictionary = Dictionary<Message.FieldTag, AnyObject>()
        for (key, tag) in PlistClientsProvider.keysAndMessageTags {
            if let value = dictionary[key] {
                messageDictionary[tag] = value
            }
        }
        
        return Message(dictionary: messageDictionary)
    }
}
