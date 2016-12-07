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
import MessageUI
import FirebaseAuth
import FirebaseAuthUI
import GoogleSignIn

class MemberManagementViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let myURL = Bundle.main.url(forResource: "calendarHTML", withExtension: "html")
    var mssgBody: String?
    var mail: MFMailComposeViewController?
    
    @IBOutlet weak var memberNameLabel: UILabel!
    // shows name of user
    
    @IBOutlet weak var joinDateLabel: UILabel!
    // shows date user joined
    
    
    @IBAction func giveFeedbackButton(_ sender: Any) {
        
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            do {
            
                try FIRAuth.auth()?.signOut()
                FirebaseAuth.signOutUser()
                GIDSignIn.sharedInstance().signOut()
                GIDSignIn.sharedInstance().disconnect()
            
            } catch {
                print("ERROR SIGNING OUT USER")
            }
            NotificationCenter.default.post(name: .closeMainVC, object: nil, userInfo: nil)
        }
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
    
    func MFMailComposeViewController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


