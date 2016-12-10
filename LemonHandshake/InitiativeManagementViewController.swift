//
//  InitiativeManagementViewController.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 12/6/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import MessageUI

class InitiativeManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MemberRemovalDelegate {

    @IBOutlet weak var memberTable: UITableView!
    
    @IBOutlet weak var initiativeNameTextField: UITextField!
    
    @IBOutlet weak var initiativeDescriptionTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var deleteInitiativeButton: UIButton!
    
    var initiative: Initiative!
    var members = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextFields()
        setUpButtons()
        
        memberTable.delegate = self
        memberTable.dataSource = self
        memberTable.allowsSelection = false
        
        getUsers()
        
    }
    
    func setUpTextFields() {
        
        initiativeNameTextField.text = initiative.name
        initiativeDescriptionTextView.text = initiative.initiativeDescription
        
    }
    
    func setUpButtons() {
        saveButton.layer.cornerRadius = 10
        deleteInitiativeButton.layer.cornerRadius = 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell") as? InitiativeManagementMemberTableViewCell
        
        cell?.member = members[indexPath.row]
        cell?.delegate = self
        
        return cell!
    }
    
    func getUsers() {
        
        FirebaseAPI.retrieveMembers(forInitiativeWithKey: initiative.databaseKey) { (users) in
            
            self.members = users
            for (index, member) in self.members.enumerated() {
                if member.databaseKey == FirebaseAuth.currentUserID {
                    self.members.remove(at: index)
                    break
                }
            }
            OperationQueue.main.addOperation {
                self.memberTable.reloadData()
            }
        }
    }
    
    func removeSelectedMembers() {
        guard let indexPaths = memberTable.indexPathsForSelectedRows else { return }
        
        var usersToRemove = [User]()
        
        for indexPath in indexPaths {
            let userToRemove = self.members[indexPath.row]
            usersToRemove.append(userToRemove)
        }
        
        for user in usersToRemove {
            FirebaseAPI.initiativeLeaderRemove(userWithKey: user.databaseKey, fromInitiativeWithKey: initiative.databaseKey)
        }
    }
    
    func banSelectedMembers() {
        guard let indexPaths = memberTable.indexPathsForSelectedRows else { return }
        
        var usersToRemove = [User]()
        
        for indexPath in indexPaths {
            let userToRemove = self.members[indexPath.row]
            usersToRemove.append(userToRemove)
        }
        
        for user in usersToRemove {
            FirebaseAPI.initiativeLeaderRemove(userWithKey: user.databaseKey, fromInitiativeWithKey: initiative.databaseKey)
        }
    }

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let name = initiativeNameTextField.text!
        let description = initiativeDescriptionTextView.text!
        
        if initiativeNameTextField.text != "" && initiativeDescriptionTextView.text != "" {
            FirebaseAPI.updateInitiative(withKey: initiative.databaseKey, withName: name, description: description)
            
            
            let alertController = UIAlertController(title: "Saved", message: "Your initiative has been updated.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { completion -> Void in
                self.dismiss(animated: true, completion: nil)
                
                
                let index = (self.navigationController?.viewControllers.count)! - 3
                
                let _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[index])!, animated: true)
                
            })
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteInitiativeButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete Initiative?", message: "This action cannot be undone.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { completion -> Void in
            
            FirebaseAPI.archive(initiative: self.initiative)
            
            let index = (self.navigationController?.viewControllers.count)! - 3
            
            let _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[index])!, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default) { completion -> Void in
        }
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func removeUser(withKey key: String) {
        let alertController = UIAlertController(title: "Remove User?", message: "This will remove a user from the initiative, but they will be able to join again should they wish. To ban a user from accessing your initiative, press cancel and ban them. ", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { completion -> Void in
            FirebaseAPI.initiativeLeaderRemove(userWithKey: key, fromInitiativeWithKey: self.initiative.databaseKey)
            self.getUsers()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { completion -> Void in
        }
        
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func banUser(withKey key: String) {
        let alertController = UIAlertController(title: "Ban User?", message: "This will ban a user from the initiative, and they will not be able to join again. To simply remove a user, please press cancel and remove them. ", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { completion -> Void in
            FirebaseAPI.initiativeLeaderBan(userWithKey: key, fromInitiativeWithKey: self.initiative.databaseKey)
            self.getUsers()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { completion -> Void in
        }
        
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
