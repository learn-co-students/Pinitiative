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
    
    //var chatCollectionView: JSQMessagesCollectionView!
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.orange)
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.blue)
    var messages = [FIRDataSnapshot]()
    var ref: FIRDatabaseReference!
    fileprivate var refHandle: FIRDatabaseHandle!
    
    var sendersId: String!
    var sendersDisplayName: String!
    let chatchatCollectionView: JSQMessagesCollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatCollectionView.reloadData()
    }

    // FOR FORMING VIEW CONTROLLER (will move struct)
    
    struct MessageFields {
        static let name = "name"
        static let text = "text"
        static let photoURL = "photoURL"
        static let imageURL = "imageURL"
    }
    
    
    let layout: JSQMessagesCollectionViewFlowLayout = JSQMessagesCollectionViewFlowLayout()
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    

    
    
    
    
    
    
    
    //FOR HANDLING MESSAGES
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
//        
//        let data = self.messages[indexPath.row]
//        return data
        
        let cell = self.chatCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        
        let messageSnapShot = self.messages[indexPath.row]
        let message = messageSnapShot.value as! [String:String]
        let name = message[MessageFields.name]! as String
        let text = message[MessageFields.text]! as String
        let textView = UIView()
        cell.contentView.addSubview(textView)

    }
    
    

    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        self.messages.remove(at: indexPath.row)
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //create a message object
        //append it to the array
    }
    
    
    
    
    
    // FOR MESSAGE BUBBLES ATTRIBUTES
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
/*    func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
    
  } */
    
 


}





