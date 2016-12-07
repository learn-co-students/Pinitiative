//
//  InitiativeManagementMemberTableViewCell.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 12/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class InitiativeManagementMemberTableViewCell: UITableViewCell {
    
    var member: User!
    
    var removeButton = UIButton()
    var banButton = UIButton()
    
    override func layoutSubviews() {
        setUpButtons()
        setUpTextLabel()
    }
    
    func setUpButtons() {
        self.contentView.addSubview(banButton)
        self.contentView.addSubview(removeButton)
        
        banButton.backgroundColor = UIColor.red
        removeButton.backgroundColor = UIColor.orange
        
        banButton.translatesAutoresizingMaskIntoConstraints = false
        
        banButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        banButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        banButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        banButton.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1.5).isActive = true
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        removeButton.trailingAnchor.constraint(equalTo: banButton.leadingAnchor).isActive = true
        removeButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        removeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        removeButton.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1.5).isActive = true
    }
    
    func setUpTextLabel() {
        textLabel?.text = "\(member.firstName) \(member.lastName)"
        
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel?.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        textLabel?.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        textLabel?.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        textLabel?.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor).isActive = true
    }

}