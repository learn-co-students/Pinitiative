//
//  FirebaseChatViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Firebase

class FirebaseChatViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    var initiativeID: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        }

    
    func creatChat() {
    
        ref = FIRDatabase.database().reference()
        
        let chatRef = ref.child("Chats").child(initiativeID)
        
        
    
    }
    

}


//chatmessages -> initiativeID -> messageID -> (content, timestamp, userID) 


