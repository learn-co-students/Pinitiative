    //
//  InitiativeDetailViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import SnapKit


class InitiativeDetailViewController: UIViewController {
    
    @IBOutlet weak var InitiativeNameLabel: UILabel!
    
    @IBOutlet weak var dateStartedLabel: UILabel!
    
    @IBOutlet weak var leaderLabel: UILabel!
    
    @IBOutlet weak var followersTextLabel: UILabel!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var descriptionTextHere: UIView!
    
    @IBOutlet weak var chatButtonLabel: UIButton!
    
    @IBOutlet weak var topSeparatorView: UIView!
    
    @IBOutlet weak var leaveButton: UIButton!
    
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var manageButton: UIButton!
    
    var initiative: Initiative!
    
    var leader: User = User.blank
    
    var userIsMember: Bool = false
    
    var currentUserDisplayName  = ""
    
    var currentUser: User!
    
    @IBAction func chatButtonTapped(_ sender: UIButton) {
        
        print("GETTING CALLED????")
        
        let key = FirebaseAuth.currentUserID
        
        FirebaseAPI.retrieveUser(withKey: key) { (userDetails) in
            
            DispatchQueue.main.async {
                
                self.currentUserDisplayName = (userDetails.firstName + " "  + userDetails.lastName)
                
                self.currentUser = userDetails
                
                self.performSegue(withIdentifier: "chatButtonSegue", sender: nil)
                
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateInitiativeData()
        retrieveLeaderName()
        
        self.view.backgroundColor = UIColor.themeBlue
        
        InitiativeNameLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).multipliedBy(0.15)
            make.centerX.equalTo(self.view)
            make.width.equalTo(400)

        }
        
        dateStartedLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).multipliedBy(0.21)
            make.left.equalTo(self.view).offset(30)
            make.width.equalTo(self.view).offset(-60)

        }
        
        leaderLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).multipliedBy(0.26)
            make.left.equalTo(self.view).offset(30)
            make.width.equalTo(self.view).offset(-60)

        }
        
        followersTextLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).multipliedBy(0.32)
            make.right.equalTo(self.view).offset(-30)
            make.width.equalTo(200)

        }
        
        
        descriptionTextHere.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).multipliedBy(0.7)
            make.centerX.equalTo(self.view)
            make.width.equalTo(325)
            make.height.equalTo(200)
            descriptionTextHere.layer.cornerRadius = 20
            descriptionTextHere.layer.borderColor = UIColor.black.cgColor
            descriptionTextHere.layer.borderWidth = 1
        }
        
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionTextField.centerYAnchor.constraint(equalTo: descriptionTextHere.centerYAnchor).isActive = true
        descriptionTextField.centerXAnchor.constraint(equalTo: descriptionTextHere.centerXAnchor).isActive = true
        descriptionTextField.widthAnchor.constraint(equalTo: descriptionTextHere.widthAnchor, multiplier: 0.9).isActive = true
        descriptionTextField.heightAnchor.constraint(equalTo: descriptionTextHere.heightAnchor, multiplier: 0.9).isActive = true
        
        chatButtonLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).multipliedBy(0.8)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view)
            chatButtonLabel.layer.cornerRadius = 20
            chatButtonLabel.layer.borderColor = UIColor.black.cgColor
            chatButtonLabel.layer.borderWidth = 1
        }
        
        topSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
       
        topSeparatorView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.16).isActive = true
        topSeparatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -10).isActive = true
        topSeparatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10).isActive = true
        topSeparatorView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.19).isActive = true
        
        topSeparatorView.layer.borderWidth = 2
        topSeparatorView.layer.borderColor = UIColor.themeOrange.cgColor
        
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        joinButton.bottomAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: -10).isActive = true
        joinButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.frame.width * 0.07).isActive = true
        joinButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15).isActive = true
        joinButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
        joinButton.layer.cornerRadius = 10
        joinButton.layer.borderWidth = 1
        joinButton.layer.borderColor = UIColor.black.cgColor
        
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        leaveButton.bottomAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: -10).isActive = true
        leaveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.frame.width * 0.07).isActive = true
        leaveButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15).isActive = true
        leaveButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
        leaveButton.layer.cornerRadius = 10
        leaveButton.layer.borderWidth = 1
        leaveButton.layer.borderColor = UIColor.black.cgColor
        
        manageButton.translatesAutoresizingMaskIntoConstraints = false
        
        manageButton.bottomAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: -10).isActive = true
        manageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.frame.width * 0.07).isActive = true
        manageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        manageButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1).isActive = true
        
        manageButton.layer.cornerRadius = 10
        manageButton.layer.borderWidth = 1
        manageButton.layer.borderColor = UIColor.black.cgColor
        
        joinButton.addTarget(self, action: #selector(joinInitiativeTapped), for: .touchUpInside)
        leaveButton.addTarget(self, action: #selector(leaveInitiativeTapped), for: .touchUpInside)
        
        descriptionTextField.scrollRectToVisible(CGRect(origin: CGPoint(x: 0, y: 0), size: descriptionTextField.frame.size), animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
        testIfUserIsMember()
    }
    func populateInitiativeData() {
        InitiativeNameLabel.text = initiative.name
        dateStartedLabel.text = "Started: \(initiative.createdAt.formattedAs("MM/dd/yy"))"
        leaderLabel.text = "Leader: "
        followersTextLabel.text = "Followers: \(initiative.members.count)"
        descriptionTextField.text = initiative.initiativeDescription
    }
    
    func retrieveLeaderName() {
        FirebaseAPI.retrieveUser(withKey: initiative.leader) { (user) in
            self.leader = user
            OperationQueue.main.addOperation {
                self.leaderLabel.text = "Leader: \(user.firstName) \(user.lastName)"
            }
        }
        
    }
    
    func testIfUserIsMember() {
        print("Testing for user")
        if FirebaseAuth.currentUserID != initiative.leader {
            print("1")
            FirebaseAPI.test(ifUserWithID: FirebaseAuth.currentUserID, isMemberOfInitiativeWithID: initiative.databaseKey) { (userIsMember) in
                print("2")
                self.userIsMember = userIsMember
                
                OperationQueue.main.addOperation {
                    
                    print("3")
                    if userIsMember {
                        self.leaveButton.isHidden = false
                    } else {
                        print("4")
                        self.testForBan()
                        self.chatButtonLabel.isHidden = true
                    }
                }
            }
        } else {
            manageButton.isHidden = false
        }
        
    }
    
    func testForBan() {
        print("5")
        FirebaseAPI.bansForUser(WithKey: FirebaseAuth.currentUserID) { (bans) in
            print("6")
            if bans[self.initiative.databaseKey] == nil {
                print("7")
                OperationQueue.main.addOperation {
                    print("8")
                    self.joinButton.isHidden = true
                }
            } else {
                print("User is banned, join button will not turn on")
            }
        }
    }
    
    func joinInitiativeTapped() {
        FirebaseAPI.userJoin(initiativeWithKey: initiative.databaseKey)
        joinButton.isHidden = true
        print("User has joined the initiative, join button turning off")
        leaveButton.isHidden = false
        chatButtonLabel.isHidden = false
        
        
        FirebaseAPI.retrieveInitiative(withKey: initiative.databaseKey) { (initiative) in
            self.initiative = initiative
            
            OperationQueue.main.addOperation {
                self.populateInitiativeData()
                self.retrieveLeaderName()
            }
        }
    }
    
    func leaveInitiativeTapped() {
        FirebaseAPI.userLeave(initiativeWithKey: initiative.databaseKey)
        joinButton.isHidden = false
        print("User has left the initiative, join button turning on")
        leaveButton.isHidden = true
        chatButtonLabel.isHidden = true
        
        
        FirebaseAPI.retrieveInitiative(withKey: initiative.databaseKey) { (initiative) in
            self.initiative = initiative
            
            OperationQueue.main.addOperation {
                self.populateInitiativeData()
                self.retrieveLeaderName()
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chatButtonSegue" {
            let dest = segue.destination as! ChatDetailViewController
            dest.initiative = initiative
            dest.user = self.currentUser
            dest.senderId = currentUser.databaseKey
            
            print("\n")
            print("Sender ID of dest is \(dest.senderId)")
            dest.senderDisplayName = currentUserDisplayName
        } else if segue.identifier == "manageMembers" {
            let dest = segue.destination as? InitiativeManagementViewController
            dest?.initiative = initiative
        }
    }
    

}
