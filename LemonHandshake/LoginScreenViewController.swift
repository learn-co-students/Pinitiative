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

    
    @IBAction func createAccountButton(_ sender: Any) {
        let authUI = FUIAuth.init(uiWith: FIRAuth.auth()!)
        
        authUI?.delegate = self
        
        authUI?.providers = [FUIGoogleAuth()]
        //            FUIFacebookAuth(), FUIGoogleAuth()]
                
        let authViewController = authUI?.authViewController()
        self.present(authViewController!, animated: true)
    }
    
    @IBOutlet weak var createAccountFrameView: UIView!
    @IBOutlet weak var createAccountButtonView: UIButton!
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (FIRAuth.auth()?.currentUser) != nil {
           
            NotificationCenter.default.post(name: .closeLoginVC, object: nil)
            
        } else {
            print("LOGIN FLOW: this is NOT a current user")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAccountFrameView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(0)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(self.view).multipliedBy(1.05)
            make.height.equalTo(self.view).multipliedBy(0.2)
            createAccountFrameView.layer.borderColor = UIColor.themeOrange.cgColor
            createAccountFrameView.layer.borderWidth = 3
        }
        
        createAccountButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        createAccountButtonView.centerXAnchor.constraint(equalTo: createAccountFrameView.centerXAnchor).isActive = true
        createAccountButtonView.centerYAnchor.constraint(equalTo: createAccountFrameView.centerYAnchor).isActive = true
        createAccountButtonView.heightAnchor.constraint(equalTo: createAccountFrameView.heightAnchor, multiplier: 0.4).isActive = true
        createAccountButtonView.widthAnchor.constraint(equalTo: createAccountFrameView.widthAnchor, multiplier: 0.8).isActive = true
        
        createAccountButtonView.layer.cornerRadius = 10
        createAccountButtonView.layer.borderColor = UIColor.themeOrange.cgColor
        createAccountButtonView.layer.borderWidth = 3
        
        
        
    }
    
    
    // conforming to Firebase UI protocol
    public func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        
    }
    
    
    
    
}




