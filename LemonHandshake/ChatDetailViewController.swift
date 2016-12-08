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
import SnapKit


class ChatDetailViewController: JSQMessagesViewController {
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.orange)
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.blueX)
    var image: String!
    var messages = [JSQMessage]()
    var ref: FIRDatabaseReference!
    var initiative: Initiative!
    var user: User!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        self.inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.backgroundColor = UIColor.greenX
        jsqSetCollectionViewInsetsTopValue(0.0, bottomValue: 100.0)
        connectToChat()
    }
    
    
    func connectToChat() {
        ref = FIRDatabase.database().reference()
        guard let initiative = initiative else { return }
        let chatRef = ref.child("Chats").child(initiative.databaseKey)
        let msgRef = chatRef.child("Messages")
        msgRef.observe(.childAdded, with: { snapshot in
            let messageDictionary = snapshot.value as! [String:String]
            print("Dictionary \(messageDictionary)")
            guard let username = messageDictionary["username"] else { return }
            guard let message = messageDictionary["message"] else { return }
            guard let userID = messageDictionary["userID"] else { return }
            guard let jsqMessage = JSQMessage(senderId: userID, displayName: username, text: message) else { return }
            self.messages.append(jsqMessage)
            self.collectionView.reloadData()
        })
        
        let usersRef = ref.child("Members").child(initiative.databaseKey)
        usersRef.observe(.childAdded, with: { snapshot in
            let users = snapshot.value as! [String : String]
            let userKeys = users.keys
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
        if badWordFilter(text: text) == true {
            print("don't send theyre cursing")
        }else{
            ref = FIRDatabase.database().reference()
            guard let initiative = initiative else { return }
            let chatRef = ref.child("Chats").child(initiative.databaseKey)
            let msgRef = chatRef.child("Messages")
            var dict = [String:String]()
            dict["username"] = self.senderDisplayName
            dict["message"] = text
            dict["userID"] = self.senderId
            msgRef.childByAutoId().setValue(dict, withCompletionBlock: { (erorr, ref) in
                self.finishSendingMessage()
                self.jsqSetCollectionViewInsetsTopValue(0.0, bottomValue: 100.0)
            })
        }
    }
    
    
    func jsqSetCollectionViewInsetsTopValue(_ top: CGFloat, bottomValue bottom: CGFloat) {
        var insets = UIEdgeInsetsMake(top, 0.0, bottom, 0.0)
        self.collectionView!.contentInset = insets
        self.collectionView!.scrollIndicatorInsets = insets
        if self.automaticallyScrollsToMostRecentMessage {
            self.scrollToBottom(animated: true)
        }
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
        
        let currentMessage = messages[indexPath.item]
        let incomingUserName = currentMessage.senderDisplayName
        if currentMessage.senderId == senderId {
            // Outgoing
            return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: generateInitials(senderDisplayName: senderDisplayName), backgroundColor: UIColor.lightGray, textColor: UIColor.white, font: UIFont.avenir, diameter: UInt(50.0))
        } else {
            // Incoming
            return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: generateInitials(senderDisplayName: incomingUserName ?? "No Name"), backgroundColor: UIColor.lightGray, textColor: UIColor.white, font: UIFont.avenir, diameter: UInt(50.0))
        }
    }
    
    
    // FILTERING TOOLBAR INPUT
    
    func badWordFilter(text: String) -> Bool {
        let badWords = BadWords.sharedInstance.badWordsList
        let textArray = text.components(separatedBy: " ")
        for word in textArray{
            if badWords.contains(word.lowercased()) {
                let alert = UIAlertController(title: "Oops!", message: "You can't curse here.", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK Cool", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return true
            }
        }
        return false
    }
    
}




