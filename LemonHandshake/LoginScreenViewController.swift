//
//  LoginScreenViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI


class LoginScreenViewController: UIViewController, FUIAuthDelegate {

    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let authUI = FUIAuth.init(uiWith: FIRAuth.auth()!)
        
        authUI?.delegate = self
        
        authUI?.providers = [FUIGoogleAuth()]
        //            FUIFacebookAuth(), FUIGoogleAuth()]
        
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true)
    }
    
    @IBOutlet weak var loginButtonView: UIButton!
    
    @IBOutlet weak var createAccountButtonView: UIButton!
   
    @IBOutlet weak var applicationLogo: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("PROGRESS: View Will Appear Runs")
        
        if let userID = FirebaseAuth.currentUserID {
            
            let ref = FIRDatabase.database().reference().child("users").child(userID)
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:String] {
                    
                    if let name = dictionary["firstName"] {
                        print("SUCCESS: \(name) is already in the database")
                    }
                }else {
                    print("SUCCESS: New user is being stored in the database (Point 2)")
                    FirebaseAPI.storeNewUser(id: userID, firstName: "Test", lastName: "Name")
                }
            })
            
            print("PROGRESS: Should Perform segue, and move into ")
            
//            performSegue(withIdentifier: "signedInSegue", sender: self)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let navVC = storyboard.instantiateViewController(withIdentifier: "navID") as! UINavigationController
            
            
            
        } else {
            
            print("PROGRESS: No user signed in, ignoring segue")
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
            backgroundView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(2)
            make.center.equalTo(self.view).offset(50)
            }
        
            usernameTextField.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-410)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(200)
            usernameTextField.layer.cornerRadius = 15
            usernameTextField.layer.borderColor = UIColor.black.cgColor
            usernameTextField.layer.borderWidth = 1
            }
        
            passwordTextField.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-360)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(200)
            passwordTextField.layer.cornerRadius = 15
            passwordTextField.layer.borderColor = UIColor.black.cgColor
            passwordTextField.layer.borderWidth = 1
            }
        
            loginButtonView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-300)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(150)
            loginButtonView.layer.cornerRadius = 20
            loginButtonView.layer.borderColor = UIColor.white.cgColor
            loginButtonView.layer.borderWidth = 1
            }
        
            createAccountButtonView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(0)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(self.view).multipliedBy(1.05)
            make.height.equalTo(self.view).multipliedBy(0.08)
            createAccountButtonView.layer.borderColor = UIColor.green.cgColor
            createAccountButtonView.layer.borderWidth = 3
            }
        
            applicationLogo.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(0)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(self.view).multipliedBy(1.05)
            make.height.equalTo(self.view).multipliedBy(0.15)
            applicationLogo.layer.borderColor = UIColor.green.cgColor
            applicationLogo.layer.borderWidth = 3
        
        }
      
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToMapSegue" {
            let dest = segue.destination
        }
    }
    
    
    // conforming to Firebase UI protocol
    public func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
    
    }
    
    

    
}




