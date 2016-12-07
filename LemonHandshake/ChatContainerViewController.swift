//
//  ChatContainerViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 12/2/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ChatContainerViewController: UIViewController {
    
    var initiative: Initiative!
    var user: User!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSUserDefaultsStore()
        
        
        let vc = self.childViewControllers.first! as! ChatDetailViewController

        
//        vc.senderDisplayName = "\(user.firstName) \(user.lastName)"
//        vc.senderId = user.databaseKey
//        vc.initiative = initiative
//        vc.user = user
        

    }

   
    func NSUserDefaultsStore() {
        
        let defaults = UserDefaults.standard
        let senderId = user.databaseKey
        let senderDisplayName = "\(user.firstName) \(user.lastName)"
        
        print("\n")
        print("Sender Display Name: \(senderDisplayName)")
        
        defaults.set(senderDisplayName, forKey: senderId)
    }
   
    

   

}
