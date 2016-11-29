//
//  ChatDetailViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatDetailViewController: JSQMessagesViewController {
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.orange)
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.blue)
    var messages = [JSQMessage]()
    //var sendersId: String!
    //var sendersDisplayName: String!
    
    var ref: FIRDatabaseReference!
    fileprivate var refHandle: FIRDatabaseHandle!
    
    //testing with rand generated initiative id
    var initiativeiD = UUID().uuidString
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = "2"
        self.senderDisplayName = "Tameika"
        connectToChat()
        print(messages)
        
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        // also have outgoing here, fyi
        
    }
    
    func connectToChat() {
        
        ref = FIRDatabase.database().reference()
        
        let chatRef = ref.child("Chats").child(initiativeiD)
        
        
        chatRef.observe(.childAdded, with: { snapshot in

            let messageDictionary = snapshot.value as! [String : String]
            
            let userID = messageDictionary["user"]
            let message = messageDictionary["message"]

            
            guard let jsqMessage = JSQMessage(senderId: self.senderId, senderDisplayName: self.senderDisplayName, date: nil, text: message) else { return }

           self.messages.append(jsqMessage)
            
        })
        
        
        
        let usersRef = ref.child("Members").child(initiativeiD)
        
        usersRef.observe(.childAdded, with: { snapshot in
            
            let users = snapshot.value as! [String : String]
            
            let userKeys = users.keys
            // userKeys will be an array of [A712, B614]
            
            for user in userKeys {
                
                let individualUserRef = self.ref.child("Users")
                
                individualUserRef.observeSingleEvent(of: .value, with: { snapshot in
                    
                    let userInfo = snapshot.value as! [String : String]
                    
                    let name = userInfo["name"] ?? "No Name"
                
                })
                
                
            }
            
            
            
        })
        
        
    }
    
    
    
    //FOR HANDLING MESSAGES
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.messages.count)
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
//        
//                let messageSnapShot = self.messages[indexPath.row]
//                let message = messageSnapShot.value as! [String:String]
//                let name = message[MessageFields.name]! as String
//                let text = message[MessageFields.text]! as String
//                var textMessage = JSQMessage(senderId: name, displayName: name, text: text)
//        
//        let textMessage = self.messages[indexPath.row]
//        print(textMessage)
//        return textMessage
        
    }
    
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        self.messages.remove(at: indexPath.row)
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //create a message object
        //append it to the array
       
        ref = FIRDatabase.database().reference()
        
        let chatRef = ref.child("Chats").child(initiativeiD)
        
        let messageObject = ["text": text,
                             "sender": senderId,
                             "displayName": senderDisplayName,
                             "date": nil]
        chatRef.setValue(messageObject)
        
//        guard let newMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text) else { return }
//        print(newMessage)
//        self.messages.append(newMessage)
//        
        
        self.collectionView.reloadData()
    }
    
    
    
    
    // FOR MESSAGE BUBBLES ATTRIBUTES
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubble
        } else {
            return incomingBubble
        }
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    
    
    
    
}



// MESSAGE DATA FOR TESTING

//    func loadMessages() {
//
//        guard let message1 = JSQMessage(senderId: "1", displayName: "Johann", text: "Hey") else { return }
//        guard let message2 = JSQMessage(senderId: "1", displayName: "Johann", text: "Hi") else { return }
//        guard let message3 = JSQMessage(senderId: "1", displayName: "Johann", text: "Hello") else { return }
//
//        guard let message4 = JSQMessage(senderId: "2", displayName: "Tameika", text: "Hola") else { return }
//        guard let message5 = JSQMessage(senderId: "2", displayName: "Tameika", text: "Buenos Dias") else { return }
//        guard let message6 = JSQMessage(senderId: "2", displayName: "Tameika", text: "Buenos Tardes") else { return }
//
//        self.messages.append(message1)
//        self.messages.append(message2)
//        self.messages.append(message3)
//        self.messages.append(message4)
//        self.messages.append(message5)
//        self.messages.append(message6)
//
//    }


