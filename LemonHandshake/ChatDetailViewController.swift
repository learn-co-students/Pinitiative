//
//  ChatDetailViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatDetailViewController: JSQMessagesViewController {
    
    var chatCollectionView: JSQMessagesCollectionView!
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.orange)
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.blue)
    var messages = [JSQMessage]()
    
    var sendersId: String!
    var sendersDisplayName: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatCollectionView.reloadData()
    }

    // FOR FORMING VIEW CONTROLLER
    
 
    
    
    let layout: JSQMessagesCollectionViewFlowLayout = JSQMessagesCollectionViewFlowLayout()
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    //let chatCollectionView: JSQMessagesCollectionView = JSQMessagesCollectionView
    
    
    
    
    //FOR HANDLING MESSAGES
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        self.messages.remove(at: indexPath.row)
    }
    
    
    
    
    // FOR MESSAGE BUBBLES ATTRIBUTES
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
/*    func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
    
  } */
    
 


}
























//extension ChatDetailViewController {
//    
//    func addDemoMessages() {
//        for i in 1...10 {
//            let sender = (i % 2 == 0) ? "Server" : self.senderID
//            let messageContent = "This is message #\(i)"
//            let message = JSQMessage(senderId: sender, displayName: sender, text: messageContent)
//            self.messages += [message]
//        }
//    }
//        // reload messages view here
//}
