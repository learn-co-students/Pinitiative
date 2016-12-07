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
    
    
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
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
    
    
    @IBOutlet weak var deleteAccountButton: UIButton!
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete Account?", message: "This action cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { completion -> Void in
            
            FirebaseAPI.archive(userWithKey: FirebaseAuth.currentUserID)
            
            NotificationCenter.default.post(name: .closeMainVC, object: nil, userInfo: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { completion -> Void in
        }
        
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var calendarWebView: UIWebView!
    
    @IBOutlet weak var calendarLabel: UILabel!
    
    
    @IBOutlet weak var feedbackButton: UIButton!
    @IBAction func giveFeedbackButton(_ sender: Any) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        print(mailComposeViewController.description)
        if terribleMessyFunction() {
            
            self.present(mailComposeViewController, animated: true, completion: nil)
            
        } else {
            
            self.showSendMailErrorAlert()
        }
        
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = terribleMessyVariable
        
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
        
        let scale = self.view.frame.width / 415
        
        calendarWebView.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        setUpViews()
    }
    
    func setUpViews() {
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        memberNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        memberNameLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        FirebaseAPI.retrieveUser(withKey: FirebaseAuth.currentUserID) { (user) in
            OperationQueue.main.addOperation {
                self.memberNameLabel.text = "\(user.firstName) \(user.lastName)"
            }
        }
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoutButton.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor, constant: 10).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: memberNameLabel.centerXAnchor, constant: self.view.frame.width * -0.25).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: memberNameLabel.widthAnchor, multiplier: 1/4).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: logoutButton.widthAnchor, multiplier: 3/5).isActive = true
        
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.borderColor = UIColor.black.cgColor
        logoutButton.layer.borderWidth = 2
        
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteAccountButton.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor, constant: 10).isActive = true
        deleteAccountButton.widthAnchor.constraint(equalTo: logoutButton.widthAnchor, multiplier: 1.4).isActive = true
        deleteAccountButton.heightAnchor.constraint(equalTo: logoutButton.heightAnchor).isActive = true
        deleteAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.frame.width * 0.25).isActive = true
        
        deleteAccountButton.layer.cornerRadius = 10
        deleteAccountButton.layer.borderColor = UIColor.black.cgColor
        deleteAccountButton.layer.borderWidth = 2
        
        
        let scale = self.view.frame.width / 415
        
        calendarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        calendarLabel.bottomAnchor.constraint(equalTo: calendarWebView.topAnchor, constant: 180 * (1 - scale)).isActive = true
        calendarLabel.centerXAnchor.constraint(equalTo: calendarWebView.centerXAnchor).isActive = true
        calendarLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        calendarLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        
        feedbackButton.translatesAutoresizingMaskIntoConstraints = false
        
        feedbackButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        feedbackButton.topAnchor.constraint(equalTo: deleteAccountButton.bottomAnchor, constant: 30).isActive = true
        feedbackButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        feedbackButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
    }
    
    func MFMailComposeViewController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


func terribleMessyFunction () -> Bool {
    return MFMailComposeViewController.canSendMail()
}

var terribleMessyVariable: MFMailComposeViewController {
    return MFMailComposeViewController()
}

