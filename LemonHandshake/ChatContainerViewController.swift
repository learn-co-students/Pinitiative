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

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = self.childViewControllers.first! as! ChatDetailViewController
        vc.initiative = initiative
        

    }

   
    
   
    

   

}
