//
//  Message.swift
//  FirebaseChat
//
//  Created by Kobe McKee on 6/25/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation
import MessageKit
import Firebase

// MARK: - MessageThread
struct MessageThread {
    
    let title: String
    let id: String
    var messages: [Message]
    
    var dictionaryRepresentation: [String: Any] {
        return ["title": title,
                "id": id,
                "messages": messages]
    }
    
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String,
            let id = dictionary["id"] as? String,
            let messages = dictionary["messages"] as? [Message] else { return nil }
        
        
        self.title = title
        self.id = id
        self.messages = messages
    }

    init(title: String, messages: [Message] = [], id: String = UUID().uuidString) {
        self.title = title
        self.messages = messages
        self.id = id
    }
    
}



// MARK: - Message

struct Message: MessageType {
    
    var messageThread: MessageThread
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    var text: String
    
    
    var dictionaryRepresentation: [String: Any] {
        return ["messageThead": messageThread,
                "sender": sender,
                "messageId": messageId,
                "sentDate": sentDate,
                "kind": kind,
                "text": text]
    }
    
    
    init?(dictionary: [String: Any]) {
        guard let messageThread = dictionary["messageThread"] as? MessageThread,
            let senderId = dictionary["senderId"] as? String,
            let displayName = dictionary["displayName"] as? String,
            let messageId = dictionary["messageId"] as? String,
            let sentDate = dictionary["sentDate"] as? Date,
            let text = dictionary["text"] as? String else { return nil }
        
        
        let sender = Sender(displayName: displayName, senderId: senderId)
        
        self.messageThread = messageThread
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = .text(text)
        self.text = text
        
    }
    
    
    init(messageThread: MessageThread, sender: SenderType, sentDate: Date, messageId: String, text: String) {
        self.messageThread = messageThread
        self.sender = sender
        self.sentDate = sentDate
        self.kind = .text(text)
        self.messageId = messageId
        self.text = text
    }
    
}




// MARK: - Sender 

struct Sender: SenderType, Codable {
    
    var senderId: String
    var displayName: String
    
    init(displayName: String, senderId: String) {
        self.displayName = displayName
        self.senderId = senderId
    }
    
}
