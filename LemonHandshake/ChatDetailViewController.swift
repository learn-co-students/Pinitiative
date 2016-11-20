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
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.orange)
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.lightGray)
    var messages = [JSQMessage]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatCollectionView.reloadData()
    }

    let layout: JSQMessagesCollectionViewFlowLayout = JSQMessagesCollectionViewFlowLayout()
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    //let chatCollectionView: JSQMessagesCollectionView = JSQMessagesCollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        let data = self.messages[indexPath.row]
        return data
    }

    
 
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
