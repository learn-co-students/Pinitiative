//
//  MyInitiativesTableViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

class MyInitiativesTableViewController: UITableViewController {
    
    var userInitiatives = [Initiative]()
    
    let store = MapDataStore.sharedInstance
    
    @IBOutlet weak var lineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func retrieveMyInitiatives() {
        FirebaseAPI.retrieveInitiativesFor(userKey: FirebaseAuth.currentUserID) { (initiatives) in
            initiatives.forEach{ initiative in
                self.userInitiatives.append(initiative)
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userInitiatives.removeAll()
        retrieveMyInitiatives()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInitiatives.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "initiativeCell", for: indexPath) as! MyInitiativesTableViewCell
        cell.contentView.backgroundColor = UIColor.clear
        let userInitiative = userInitiatives[indexPath.row]
        cell.initiativeLabel.text = userInitiative.name
        cell.followersLabel.text = "Members: \(userInitiative.members.count)"
        cell.dateLabel.text = "Start date: \(userInitiative.createdAt.formattedAs("MM/dd/yyyy"))"
        if userInitiative.associatedLandmark != nil {
            if let landmark = userInitiative.associatedLandmark {
                cell.landmarkLabel.text = " \(landmark.name)"
                cell.landmarkTypePreview.image = landmark.tableViewIcon }
        } else {
            cell.landmarkLabel.text = "Custom Location"
            cell.landmarkTypePreview.image = UIImage(named: "CustomLocationTableViewIcon")
        }
        return cell
    }
    
    //MARK: Table View Cell animation:
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1, 1)

        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05, 1.05, 1)
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, animations: { 
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
            
        })
    
    }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initiativeToDetailSegue" {
            let dest = segue.destination as! InitiativeDetailViewController
            dest.initiative = userInitiatives[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

    //MARK: Delete Cell functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let initiative = userInitiatives[indexPath.row]
            
            if initiative.leader == FirebaseAuth.currentUserID {
            let leaderAlertController = UIAlertController(title: "Delete Initiative", message: "This action cannot be undone.", preferredStyle: .alert)
                
                let okAction =  UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                   self.userInitiatives.removeAll()
                   FirebaseAPI.archive(initiative: initiative)
                    self.dismiss(animated: true, completion: nil)
                    self.retrieveMyInitiatives()
                    self.tableView.reloadData()
                })
               
             leaderAlertController.addAction(okAction)
             self.present(leaderAlertController, animated: true, completion: nil)
            } else {
                let notLeaderController = UIAlertController(title: "Warning", message: "You are  not the leader of this initiative, you cannot perform this operation", preferredStyle: .alert)
                let okAction =  UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                
                notLeaderController.addAction(okAction)
                self.present(notLeaderController, animated: true, completion: nil)
            }
        }
    }
    
    

}
