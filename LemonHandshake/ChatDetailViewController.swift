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

        // Do any additional setup after loading the view.
    }

    let layout: JSQMessagesCollectionViewFlowLayout = JSQMessagesCollectionViewFlowLayout()
    
    let chatCollectionView: JSQMessagesCollectionView = JSQMessagesCollectionView(frame: self.view.frame, collectionViewLayout: layout)
    
    
    
 
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
