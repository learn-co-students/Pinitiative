//
//  InitiativeManagementViewController.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 12/6/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import MessageUI

class InitiativeManagementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

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
        if initiativeNameTextField.text != "" && initiativeDescriptionTextView.text != "" {
            
        }
    }
    
    @IBAction func deleteInitiativeButtonTapped(_ sender: Any) {
    }
}
