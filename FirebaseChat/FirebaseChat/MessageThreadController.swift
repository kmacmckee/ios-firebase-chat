//
//  MessageThreadController.swift
//  FirebaseChat
//
//  Created by Kobe McKee on 6/25/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation
import MessageKit
import FirebaseDatabase


class MessageThreadController {
    
    var messageThreads: [Message] = []
    
    let ref = Database.database().reference()
    
    func createMessageThread(title: String) {
        let messageThread = MessageThread(title: title)
        
        ref.child("messageThreads")
            .childByAutoId()
            .setValue(messageThread.dictionaryRepresentation)
    }
    
    func fetchMessageThreads() {
        
    }
    
    func createMessage(messageThread: MessageThread, text: String, displayName: String, senderId: String) {
        
        let message = Message(messageThread: messageThread, text: text, displayName: displayName, senderId: senderId, messageId: UUID().uuidString)
        
        ref.child("messages")
            .childByAutoId()
            .setValue(message.diction)
        
    }
    
    func fetchMessages() {
        
    }
    
    
}
