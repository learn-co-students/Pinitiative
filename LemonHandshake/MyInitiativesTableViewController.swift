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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "initiativeCell", for: indexPath) as! MyInitiativesTableViewCell

            cell.contentView.backgroundColor = UIColor.clear
//        cell.layer.borderColor = UIColor.green.cgColor
//        cell.layer.borderWidth = 2
        
//        cell.initiativeLabel.snp.makeConstraints { (make) in
////            make.top.equalTo(cell.contentView)
//            make.top.equalTo(cell.contentView).offset(40)
//            make.centerX.equalTo(cell.contentView.center)
//        }
//
//        cell.dateLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(cell.contentView).offset(60)
//            make.leftMargin.equalTo(cell.contentView).offset(20)
//            
//        }
//
//        cell.dateLabel.snp.makeConstraints { (make) in
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
        let userInitiative = userInitiatives[indexPath.row]
//        
//          cell.landmarkLabel.text = userInitiative.associatedLandmark?.name
          cell.initiativeLabel.text = userInitiative.name
          cell.followersLabel.text = "Followers: \(userInitiative.members.count)"
          cell.dateLabel.text = "Start date: \(userInitiative.createdAt.formattedAs("MM/dd/yyyy"))"
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initiativeToDetailSegue" {
            let dest = segue.destination as! InitiativeDetailViewController
            dest.initiative = userInitiatives[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func animateBackground() {
        let backgrounds = ["fireStationBackground", "schoolBackground", "policeBackground", "park"]
        
        var counter = 0
        
        while counter < backgrounds.count - 1 {
        backgrounds.forEach { (background) in
                let imageView = UIImageView(image: UIImage(named: backgrounds[counter]))
                self.view.addSubview(imageView)
            
                let nextImageView = UIImageView(image: UIImage(named: backgrounds[counter + 1]))
                nextImageView.alpha = 0.0
                self.view.insertSubview(imageView, aboveSubview: nextImageView)
            
            UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
                nextImageView.alpha = 1.0
            }, completion: { _ in
                imageView.image = nextImageView.image
                imageView.contentMode = .scaleAspectFit
                imageView.alpha = 0.5
                nextImageView.removeFromSuperview() }) }
            counter += 1
        }
    }
}
