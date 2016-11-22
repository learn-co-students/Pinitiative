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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImage(named: "backgroundImage" )
        let imageView = UIImageView(image: background)
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.3
        view.sendSubview(toBack: imageView)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "initiativeCell", for: indexPath) as! MyInitiativesTableViewCell

        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.borderWidth = 2
        
        cell.initiativeLabel.text = "Pick up trash at the park"
        cell.followersLabel.text = String(describing: 54)
        cell.dateLabel.text = "October 10th, 2016"
 
       
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
