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

    override func viewDidLoad() {
        super.viewDidLoad()

        let background = UIImage(named: "backgroundImageOther" )
        let imageView = UIImageView(image: background)
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.3
        view.sendSubview(toBack: imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nearbyInitiatives", for: indexPath) as! NearbyInitiativesDetailCell

        // add the below to a xib file?
        
        
        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 2
        
        cell.nearbyInitiativeNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cell.contentView)
            make.centerX.equalTo(cell.contentView.center)
        }
        
        cell.dateStartedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cell.contentView).offset(40)
            make.leftMargin.equalTo(cell.contentView).offset(20)
            
        }
        
        cell.dateTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cell.contentView).offset(40)
            make.rightMargin.equalTo(cell.contentView).offset(-20)

        }
        
        cell.followersLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cell.contentView).offset(80)
            make.leftMargin.equalTo(cell.contentView).offset(20)

        }

        cell.followersTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cell.contentView).offset(80)
            make.rightMargin.equalTo(cell.contentView).offset(-20)

        }

        
        

        
        
        cell.nearbyInitiativeNameLabel.text = "Feed the homeless"
        cell.dateTextLabel.text = "April 1st, 2016"
        cell.followersTextLabel.text = "589"

        return cell
    }
    
   
}
