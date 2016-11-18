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

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
    }
    
    @IBOutlet weak var loginButtonView: UIButton!
    
    @IBOutlet weak var createAccountButtonView: UIButton!
   
    @IBOutlet weak var applicationLogo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

            backgroundView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view)
            make.width.equalTo(self.view).offset(250)
            make.center.equalTo(self.view)
            }
        
            usernameTextField.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-410)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(200)
            usernameTextField.layer.cornerRadius = 15
            }
        
            passwordTextField.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-360)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(200)
            passwordTextField.layer.cornerRadius = 15
            }
        
            loginButtonView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-300)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(150)
            loginButtonView.layer.cornerRadius = 20
            loginButtonView.layer.borderColor = UIColor.yellow.cgColor
            loginButtonView.layer.borderWidth = 3
            }
        
            createAccountButtonView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(0)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(self.view).multipliedBy(1.05)
            make.height.equalTo(self.view).multipliedBy(0.08)
            createAccountButtonView.layer.borderColor = UIColor.yellow.cgColor
            createAccountButtonView.layer.borderWidth = 3
            }
        
            applicationLogo.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(0)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(self.view).multipliedBy(1.05)
            make.height.equalTo(self.view).multipliedBy(0.15)
            applicationLogo.layer.borderColor = UIColor.yellow.cgColor
            applicationLogo.layer.borderWidth = 3
        
        }
}
}

   


