//
//  MemberManagementViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class MemberManagementViewController: UIViewController {
    
    let myURL = Bundle.main.url(forResource: "calendarHTML", withExtension: "html")
    
    @IBOutlet weak var memberNameLabel: UILabel!
        // shows name of user
    
    @IBOutlet weak var joinDateLabel: UILabel!
        // shows date user joined
    
    
    @IBAction func giveFeedbackButton(_ sender: Any) {
    }
    
    @IBAction func logoutButton(_ sender: Any) {
    }
    
    @IBAction func deleteAccountButton(_ sender: Any) {
    }

    @IBOutlet weak var calendarWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let requestObj = NSURLRequest(url: myURL!)
        
        
        calendarWebView.snp.makeConstraints { (make) in
            make.width.equalTo(415)
            make.height.equalTo(360)
            make.centerX.equalTo(self.view)
            make.bottomMargin.equalTo(self.view).offset(10)
            
        }
        
        calendarWebView.loadRequest(requestObj as URLRequest)
        
    }
    
}


