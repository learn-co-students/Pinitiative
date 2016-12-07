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
    
    
    
    var initiative: Initiative!
    var members = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memberTable.delegate = self
        memberTable.dataSource = self
        memberTable.allowsMultipleSelection = true
        
//        let vc = MFMailComposeViewController()
//        MFMailComposeViewController.canSendMail(){
//            
//        }
        
        
        
        getUsers()
        
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
        print("Getting Users")
        
        FirebaseAPI.retrieveMembers(forInitiativeWithKey: initiative.databaseKey) { (users) in
            
            self.members = users
            for (index, member) in self.members.enumerated() {
                if member.databaseKey == FirebaseAuth.currentUserID {
                    self.members.remove(at: index)
                    break
                }
            }
            print("Got users:")
            dump(users)
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

}
