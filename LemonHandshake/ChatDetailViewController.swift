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
    
    var messages = [JSQMessage]()
    
    var ref: FIRDatabaseReference!
    
    var initiative: Initiative! {
        didSet {
            connectToChat()
            collectionView.reloadData()

        }
    }
    
    
    @IBOutlet weak var containerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(messages)
        
        collectionView.reloadData()
        collectionView.backgroundColor = UIColor.greenX
        
        self.senderId = FirebaseAuth.currentUserID
        //self.senderDisplayName =
        
        
        
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
        if badWordFilter(text: text) == true {
            print("don't send theyre cursing")
        }else{
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
        
        
        
        let outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: generateInitials(senderDisplayName: senderDisplayName), backgroundColor: UIColor.darkGray, textColor: UIColor.white, font: UIFont.avenir, diameter: UInt(50.0))
        
        let incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: generateInitials(senderDisplayName: senderDisplayName), backgroundColor: UIColor.darkGray, textColor: UIColor.white, font: UIFont.avenir, diameter: UInt(50.0))
        
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingAvatar
        } else {
            return incomingAvatar
        }

    }
    
    
    func dequeueTypingIndicatorFooterView(for indexPath: IndexPath!) -> JSQMessagesTypingIndicatorFooterView! {
        
           let chatCell = dequeueTypingIndicatorFooterView(for: indexPath)
        
        chatCell?.configure(withEllipsisColor: UIColor.lightGray, messageBubble: UIColor.darkGray, shouldDisplayOnLeft: true, for: self.collectionView)
        
        if self.senderId == senderId, indexPath.item == indexPath.count + 1 {
            
        }
        return chatCell
    }
    

    // FILTERING TOOLBAR INPUT
    
    func badWordFilter(text: String) -> Bool {
    
        let badWords = BadWords.sharedInstance.badWordsList
        
        let textArray = text.components(separatedBy: " ")
        print(textArray)
        for word in textArray{
            if badWords.contains(word.lowercased()) {
                
                print("hey this person cursed")
                let alert = UIAlertController(title: "Oops!", message: "You can't curse here.", preferredStyle: UIAlertControllerStyle.alert)
                print("alert")
                
                let okAction = UIAlertAction(title: "OK Cool", style: .default, handler: nil)
                
                alert.addAction(okAction)
                
                self.present(alert, animated: true, completion: nil)
                return true
            }
        }
        return false
    }
    
    
}
//end












//will move to Constants -> BadWords
    extension JSQMessagesViewController {
        
        
        func generateInitials(senderDisplayName: String) -> String? {
            
            let nameCharacters = [Character](senderDisplayName.characters)
            
            guard !senderDisplayName.isEmpty, nameCharacters.first != " " else { return nil }
            
            guard nameCharacters.contains(" ") else { return String(nameCharacters.first!).uppercased() }
            
            let words = (nameCharacters.split(separator: " "))
            
            let firstWordArray = words.first!
            
            let lastWordArray = words.last!
            
            let firstNameInitial = String(firstWordArray.first!)
            
            let lastNameInitial = String(lastWordArray.first!)
            
            return firstNameInitial.uppercased() + lastNameInitial.uppercased()
            
        }
    }



//will move to Constants -> Extensions
    extension UIColor {
        static let blueX = UIColor.init(red:0.00, green:0.33, blue:0.65, alpha:1.0)
        static let greenX = UIColor(red:0.49, green:0.77, blue:0.46, alpha:1.0)
        static let lightGreen = UIColor(red:0.72, green:1.00, blue:0.62, alpha:1.0)
        static let purpleX = UIColor(red:0.15, green:0.07, blue:0.20, alpha:1.0)
    }

//will move to Constants -> Extensions
    extension UIFont {
        static let avenir = UIFont.init(name: "Avenir", size: 24.0)
    }
