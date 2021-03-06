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
    var initiative: Initiative!
    
    var delegate: MemberRemovalDelegate? = nil
    
    var removeButton = UIButton()
    var banButton = UIButton()
    
    var banLabel = UILabel()
    var removeLabel = UILabel()
    
    override func layoutSubviews() {
        setUpCells()
        setUpButtons()
        setUpTextLabel()
    }
    
    func setUpCells() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.themePurple.cgColor
        self.layer.borderWidth = 2
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
        banButton.layer.cornerRadius = 10
        
        banButton.addTarget(self, action: #selector(banButtonTapped), for: .touchUpInside)
        
        banButton.addSubview(banLabel)
        banLabel.constrainTo(banButton)
        
        banLabel.text = "Ban"
        banLabel.textAlignment = .center
        banLabel.font = UIFont(name: "Avenir", size: 12)
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
        removeButton.trailingAnchor.constraint(equalTo: banButton.leadingAnchor).isActive = true
        removeButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        removeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        removeButton.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1.5).isActive = true
        removeButton.layer.cornerRadius = 10
        
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
        removeButton.addSubview(removeLabel)
        removeLabel.constrainTo(removeButton)
        
        removeLabel.text = "Remove"
        removeLabel.textAlignment = .center
        removeLabel.font = UIFont(name: "Avenir", size: 12)
    }
    
    func setUpTextLabel() {
        textLabel?.text = "\(member.firstName) \(member.lastName)"
        
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel?.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        textLabel?.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        textLabel?.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        textLabel?.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor).isActive = true
    }
    
    func removeButtonTapped() {
        delegate?.removeUser(withKey: member.databaseKey)
    }
    func banButtonTapped() {
        delegate?.banUser(withKey: member.databaseKey)
    }

}
