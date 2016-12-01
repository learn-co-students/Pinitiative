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
    
    //let incomingBubble = JSQMessagesAvatarImage.
    
    var messages = [JSQMessage]()
    
    var ref: FIRDatabaseReference!
    
    var initiative: Initiative!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectToChat()
        print(messages)
        collectionView.reloadData()
        
        self.senderId = "2"
        self.senderDisplayName = "Tameika Lawrence"
        
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
        
        ref = FIRDatabase.database().reference()
        
        let chatRef = ref.child("Chats").child(initiative.databaseKey)
        let msgRef = chatRef.child("Messages")
        
        var dict = [String:String]()
        
        dict["username"] = self.senderDisplayName
        dict["message"] = text
        dict["userID"] = self.senderId
        
        msgRef.childByAutoId().setValue(dict)
        
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
        
        let outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: senderDisplayName, backgroundColor: UIColor.randomColor(), textColor: UIColor.randomColor(), font: UIFont.avenir, diameter: UInt(2.0))
        
        let incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: senderDisplayName, backgroundColor: UIColor.randomColor(), textColor: UIColor.randomColor(), font: UIFont.avenir, diameter: UInt(2.0))
        
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingAvatar
        } else {
            return incomingAvatar
        }

    }
    

    
    
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red:   CGFloat(drand48()),
                       green: CGFloat(drand48()),
                       blue:  CGFloat(drand48()),
                       alpha: 0.50)
    }
}

extension UIFont {
    static let avenir = UIFont.init(name: "Avenir", size: 1.0)
}
