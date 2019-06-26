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

struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    var text: String
    
    init?(dictionary: [String: Any]) {
        guard let senderId = dictionary["senderId"] as? String,
            let displayName = dictionary["displayName"] as? String,
            let messageId = dictionary["messageId"] as? String,
            let sentDate = dictionary["sentDate"] as? Date,
            let text = dictionary["text"] as? String else { return nil }
        
        
        let sender = Sender(displayName: displayName, senderId: senderId)
        
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = .text(text)
        self.text = text
        
    }
    
    
    init(sender: SenderType, sentDate: Date, messageId: String, text: String) {
        self.sender = sender
        self.sentDate = sentDate
        self.kind = .text(text)
        self.messageId = messageId
        self.text = text
    }
    
    
    
    
    
}


struct Sender: SenderType, Codable {
    
    var senderId: String
    var displayName: String
    
    init(displayName: String, senderId: String) {
        self.displayName = displayName
        self.senderId = senderId
    }
    
}
