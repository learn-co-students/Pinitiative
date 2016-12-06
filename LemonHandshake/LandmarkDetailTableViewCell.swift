//
//  LandmarkDetailTableViewCell.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 12/6/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LandmarkDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var initiativeName: UILabel!
    
    @IBOutlet weak var dateStartLabel: UILabel!
    
    @IBOutlet weak var noOfMembersLabel: UILabel!
    
    @IBOutlet weak var leaderLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
