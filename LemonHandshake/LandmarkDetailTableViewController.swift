//
//  LandmarkDetailTableViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LandmarkDetailTableViewController: UITableViewController {
    
    var landmarkInitiatives: [Initiative] = []
    let store = MapDataStore.sharedInstance
    var landmark: Landmark!
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInitiativesForLandmark()
        navItem.title = landmark.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkInitiatives.count
    }
    
    func getInitiativesForLandmark() {
        FirebaseAPI.retrieveInitiativeFor(landmarkKey: landmark.databaseKey, completion: {
            initiative in
            self.landmarkInitiatives.append(initiative)
            OperationQueue.main.addOperation {
                self.animateTable()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "landmarkDetailCell", for: indexPath) as! LandmarkDetailTableViewCell
        let initiative = landmarkInitiatives[indexPath.row]
        cell.initiativeName.text = initiative.name
        cell.dateStartLabel.text = initiative.createdAt.formattedAs("MM/dd/yyyy")
        cell.noOfMembersLabel.text = String(initiative.members.count)
        FirebaseAPI.retrieveUser(withKey: initiative.leader) { (user) in
            OperationQueue.main.addOperation {
                cell.leaderLabel.text = "Leader: \(user.firstName) \(user.lastName)"
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? InitiativeDetailViewController {
            
            dest.initiative = landmarkInitiatives[(tableView.indexPathForSelectedRow?.row)!]
            FirebaseAPI.retrieveUser(withKey: FirebaseAuth.currentUserID, completion: { (user) in
                dest.currentUser = user
            })
        }
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        
        
        cells.forEach { (cell) in
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for cell in cells {
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            index += 1
        }
    }
}
