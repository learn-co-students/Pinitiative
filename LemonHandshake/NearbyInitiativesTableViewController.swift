//
//  NearbyInitiativesTableViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

class NearbyInitiativesTableViewController: UITableViewController {

    let store = MapDataStore.sharedInstance
    
    var nearbyInitiatives = [Initiative]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let background = UIImage(named: "gardenRoad" )
//        let imageView = UIImageView(image: background)
//        self.view.addSubview(imageView)
//        imageView.contentMode = .scaleAspectFill
//        imageView.alpha = 0.4
//        view.sendSubview(toBack: imageView)
        
        retrieveNearbyInitiatives()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func retrieveNearbyInitiatives() {
        FirebaseAPI.geoFirePullNearbyInitiatives(within: 0.5, ofLocation: store.userLocation) { (initiative) in
            self.nearbyInitiatives.append(initiative)
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nearbyInitiatives.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nearbyInitiatives", for: indexPath) as! NearbyInitiativesDetailCell

        // add the below to a xib file?
        
        
//        cell.backgroundColor = UIColor.clear
//        cell.layer.borderColor = UIColor.blue.cgColor
//        cell.layer.borderWidth = 2
//        
//        cell.nearbyInitiativeNameLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(cell.contentView)
//            make.centerX.equalTo(cell.contentView.center)
//        }
//        
//        cell.dateStartedLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(cell.contentView).offset(40)
//            make.leftMargin.equalTo(cell.contentView).offset(20)
//            
//        }
//        
//        cell.dateTextLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(cell.contentView).offset(40)
//            make.rightMargin.equalTo(cell.contentView).offset(-20)
//
//        }
//        
//        cell.followersLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(cell.contentView).offset(80)
//            make.leftMargin.equalTo(cell.contentView).offset(20)
//
//        }
//
//        cell.followersTextLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(cell.contentView).offset(80)
//            make.rightMargin.equalTo(cell.contentView).offset(-20)
//
//        }
//
        

        let initiative = nearbyInitiatives[indexPath.row]
        
        cell.nearbyInitiativeNameLabel.text = initiative.name
        cell.dateStartedLabel.text = "Start Date: \(initiative.createdAt.formattedAs("MM/dd/yyyy"))"
        cell.followersLabel.text = "Followers: \(initiative.members.count)"
        return cell
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "localInitiativeDetail" {
            guard let dest = segue.destination as? InitiativeDetailViewController else { return }
            
            let initiative = nearbyInitiatives[(tableView.indexPathForSelectedRow?.row)!]
            
            dest.initiative = initiative
        }
    }
   
}
