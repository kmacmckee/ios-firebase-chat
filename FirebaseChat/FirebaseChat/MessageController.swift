//
//  MessageController.swift
//  FirebaseChat
//
//  Created by Kobe McKee on 6/25/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation
import MessageKit
import Firebase

class MessageController {
    
    var messageThreads: [MessageThread] = []
    var messages: [Message] = []
    var currentSender: Sender?
    
    let ref = Database.database().reference()
    
    func createMessageThread(title: String, completion: @escaping (Error?) -> Void) {
        
        let messageThread = MessageThread(title: title)
        
        ref.child("messageThreads")
            .childByAutoId()
            .setValue(messageThread.dictionaryRepresentation)
    }
    
    
    func fetchMessageThreads() {
        ref.child("messageThreads")
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let messageThreadDictionaries = snapshot.value as? [String: [String: Any]] else { return }
                
                for (_, value) in messageThreadDictionaries {
                    guard let messageThread = MessageThread(dictionary: value) else { continue }
                    self.messageThreads.append(messageThread)
                }
        }
    }
    
    
    
    
    func createMessage(messageThread: MessageThread, text: String) {
        guard let sender = currentSender else { return }
        let message = Message(messageThread: messageThread, sender: sender, sentDate: Date(), messageId: UUID().uuidString, text: text)
        
        ref.child("messageThreads")
            .child("messages")
            .childByAutoId()
            .setValue(message.dictionaryRepresentation)
        
    }
    
    func fetchMessages() {
        
        ref.child("messageThreads")
            .child("messages")
            .observeSingleEvent(of: .value) { (snapshot) in
                guard let messageDictionaries = snapshot.value as? [String: [String: Any]] else { return }
                
                for (_, value) in messageDictionaries {
                    guard let message = Message(dictionary: value) else { continue }
                    self.messages.append(message)
                }
        }
    }
    
}
