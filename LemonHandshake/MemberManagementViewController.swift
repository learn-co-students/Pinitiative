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
    
    @IBOutlet weak var initiativeCountLabel: UILabel!
    
    @IBAction func giveFeedbackButton(_ sender: Any) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        print(mailComposeViewController.description)
        if MFMailComposeViewController.canSendMail() {
        
            self.present(mailComposeViewController, animated: true, completion: nil)
        
        } else {
        
            self.showSendMailErrorAlert()
        }
        
    
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()

        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients(["zeitlin1@gmail.com"])
        mailComposerVC.setSubject("TEST EMAIL FROM APP")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    
    func mailcomposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
        
        FirebaseAPI.retrieveUser(withKey: FirebaseAuth.currentUserID, completion: { (user) in
            self.memberNameLabel.text = (user.firstName + " " + user.lastName)
            self.initiativeCountLabel.text = String(describing: user.initiatives.count)
        })

        calendarWebView.snp.makeConstraints { (make) in
            make.width.equalTo(415)
            make.height.equalTo(360)
            make.centerX.equalTo(self.view)
            make.bottomMargin.equalTo(self.view).offset(10)
        }
        calendarWebView.loadRequest(requestObj as URLRequest)
    }
    
   
}


