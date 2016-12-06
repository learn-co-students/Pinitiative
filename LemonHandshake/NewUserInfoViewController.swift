//
//  NewUserInfoViewController.swift
//  
//
//  Created by Christopher Boynton on 12/5/16.
//
//

import UIKit

class NewUserInfoViewController: UIViewController, UITextFieldDelegate {
    
    var welcomeLabel = UILabel()
    var welcomePinitiativeLogo = UIImageView()
    var welcomeText = UITextView()
    var welcomeFrame = UIView()
    
    var firstNameTextField = UITextField()
    
    var lastNameTextField = UITextField()
    
    var submitButton = UIButton()
    var submitLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(welcomeFrame)
        welcomeFrame.addSubview(welcomeLabel)
        welcomeFrame.addSubview(welcomePinitiativeLogo)
        welcomeFrame.addSubview(welcomeText)
        self.view.addSubview(firstNameTextField)
        self.view.addSubview(lastNameTextField)
        self.view.addSubview(submitButton)
        submitButton.addSubview(submitLabel)
        
        colorizeViews()
        constrainViews()
        customizeViews()
        
        firstNameTextField.delegate = self
        firstNameTextField.tag = 0
        lastNameTextField.delegate = self
        lastNameTextField.tag = 1
    }
    
    func colorizeViews() {
        self.view.backgroundColor = UIColor.themeBlue
        welcomeFrame.backgroundColor = UIColor.themePurple
        welcomeLabel.textColor = UIColor.white
        
        firstNameTextField.backgroundColor = UIColor.white
        firstNameTextField.layer.borderColor = UIColor.themePurple.cgColor
        lastNameTextField.backgroundColor = UIColor.white
        lastNameTextField.layer.borderColor = UIColor.themePurple.cgColor
        
        submitButton.backgroundColor = UIColor.themeOrange
        submitButton.layer.borderColor = UIColor.themePurple.cgColor
    }
    func constrainViews() {
        welcomeFrame.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeFrame.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        welcomeFrame.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        welcomeFrame.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        welcomeFrame.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeLabel.topAnchor.constraint(equalTo: welcomeFrame.topAnchor).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: welcomeFrame.leadingAnchor).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: welcomeFrame.trailingAnchor).isActive = true
        welcomeLabel.heightAnchor.constraint(equalTo: welcomeFrame.heightAnchor, multiplier: 1/2).isActive = true
        
        welcomePinitiativeLogo.translatesAutoresizingMaskIntoConstraints = false
        
        welcomePinitiativeLogo.centerXAnchor.constraint(equalTo: welcomeFrame.centerXAnchor).isActive = true
        welcomePinitiativeLogo.bottomAnchor.constraint(equalTo: welcomeFrame.bottomAnchor).isActive = true
        welcomePinitiativeLogo.heightAnchor.constraint(equalTo: welcomeFrame.heightAnchor, multiplier: 3/4).isActive = true
        welcomePinitiativeLogo.widthAnchor.constraint(equalTo: welcomeFrame.widthAnchor).isActive = true
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTextField.topAnchor.constraint(equalTo: welcomeFrame.bottomAnchor, constant: 20).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: welcomeFrame.widthAnchor, multiplier: 0.8).isActive = true
        firstNameTextField.centerXAnchor.constraint(equalTo: welcomeFrame.centerXAnchor).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20).isActive = true
        lastNameTextField.widthAnchor.constraint(equalTo: welcomeFrame.widthAnchor, multiplier: 0.8).isActive = true
        lastNameTextField.centerXAnchor.constraint(equalTo: welcomeFrame.centerXAnchor).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.topAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/5).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        submitLabel.constrainTo(submitButton)
    }
    func customizeViews() {
        welcomeFrame.layer.cornerRadius = 15
        
        welcomeLabel.text = "Welcome to"
        welcomeLabel.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        welcomeLabel.textAlignment = .center
        
        welcomeText.text = "Please enter your name. This helps your neighbors know who you are. "
        
        welcomePinitiativeLogo.image = UIImage(named: "fullLogo")
        welcomePinitiativeLogo.contentMode = .scaleAspectFit
        
        firstNameTextField.textAlignment = .center
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.layer.cornerRadius = 10
        firstNameTextField.layer.borderWidth = 2
        
        lastNameTextField.textAlignment = .center
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.layer.cornerRadius = 10
        lastNameTextField.layer.borderWidth = 2
        
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 2
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        submitLabel.text = "Submit"
        submitLabel.textAlignment = .center
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField.tag == 0 {
            textField.placeholder = "First Name"
        } else {
            textField.placeholder = "Last Name"
        }
    }
    
    func didTapSubmitButton() {
        if firstNameTextField.text != "", lastNameTextField.text != "" {
            if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text {
                FirebaseAPI.storeNewUser(id: FirebaseAuth.currentUserID, firstName: firstName, lastName: lastName)
                dismiss(animated: true)
                print("This is working, storing \(firstName) \(lastName) with ID: \(FirebaseAuth.currentUserID)")
            }
        }
    }

}
