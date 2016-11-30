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
    
    var ref: FIRDatabaseReference!
    fileprivate var refHandle: FIRDatabaseHandle!
    
    var initiative: Initiative!
    //testing with rand generated initiative id
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectToChat()
        print(messages)
        collectionView.reloadData()
        
        self.senderId = "2"
        self.senderDisplayName = "Tameika"
        
//        let uuid = UserDefaults.standard.object(forKey: "UUID") as? String
//        if let myID = uuid{
//            //then do something with uuid
//        }else{
//            let newId = UUID().uuidString
//            UserDefaults.standard.set(newId, forKey: "UUID")
//        }
        
    }
    
    
    func connectToChat() {
        
        ref = FIRDatabase.database().reference()
        
        let chatRef = ref.child("Chats").child(initiative.databaseKey)
        let msgRef = chatRef.child("Messages")
        
        msgRef.observe(.childAdded, with: { snapshot in
        print(snapshot.value)
            
        let messageDictionary = snapshot.value as! [String:String]
        print("Dictionary \(messageDictionary)")
        
        
        guard let username = messageDictionary["username"] else { return }
        guard let message = messageDictionary["message"] else { return }
        guard let userID = messageDictionary["userID"] else { return }
       
        print(username)
        print(message)
        print(userID)
        
        
        guard let jsqMessage = JSQMessage(senderId: userID, displayName: username, text: message) else { return }

        self.messages.append(jsqMessage)
        self.collectionView.reloadData()
            
            
        })
        
        
        
        let usersRef = ref.child("Members").child(initiative.databaseKey)
        
        usersRef.observe(.childAdded, with: { snapshot in
            
            let users = snapshot.value as! [String : String]
            
            let userKeys = users.keys
            // userKeys will be an array of [A712, B614]
            
            for user in userKeys {
                
                let individualUserRef = self.ref.child("Users")
                
                individualUserRef.observeSingleEvent(of: .value, with: { snapshot in
                    
                    let userInfo = snapshot.value as! [String : String]
                    
                    let name = userInfo["name"] ?? "No Name"
                    
                    usersRef.setValue(userInfo)
                   
                
                })
                
                
            }
            
            
            
        })
        
        
    }
    
    
    
    //FOR HANDLING MESSAGES IN VIEWCONTROLLER
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.messages.count)
        return self.messages.count
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        let data = messages[indexPath.row]
        return data
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        self.messages.remove(at: indexPath.row)
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //create a message object
        //append it to the array
        
        
        ref = FIRDatabase.database().reference()
        
        let chatRef = ref.child("Chats").child(initiative.databaseKey)
        let msgRef = chatRef.child("Messages")
        
        var dict = [String:String]()
        
        dict["username"] = self.senderDisplayName
        dict["message"] = text
        dict["userID"] = self.senderId
        
        msgRef.childByAutoId().setValue(dict)
//        guard let newMessage = JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, text: text) else { return }
//        
//        messages.append(newMessage)
//        print(newMessage)
        
        self.finishSendingMessage()
        
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


