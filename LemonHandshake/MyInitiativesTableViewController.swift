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
//        animateBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseAPI.retrieveInitiativesFor(userKey: FirebaseAuth.currentUserID) { (initiatives) in
            self.userInitiatives = initiatives
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInitiatives.count
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Initiatives"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "initiativeCell", for: indexPath) as! MyInitiativesTableViewCell

            cell.contentView.backgroundColor = UIColor.clear
        let userInitiative = userInitiatives[indexPath.row]
           cell.initiativeLabel.text = userInitiative.name
           cell.followersLabel.text = "Members: \(userInitiative.members.count)"
           cell.dateLabel.text = "Initiative date: \(userInitiative.createdAt.formattedAs("MM/dd/yyyy"))"
        if userInitiative.associatedLandmark != nil {
            if let landmark = userInitiative.associatedLandmark {
                cell.landmarkLabel.text = " \(landmark.name)"
                cell.landmarkTypePreview.image = landmark.tableViewIcon }
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initiativeToDetailSegue" {
            let dest = segue.destination as! InitiativeDetailViewController
            dest.initiative = userInitiatives[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func animateTableView() {
        
    }
}
