//
//  DropPin.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

protocol DropPinDelegate: class {
    func startInitiative()
    func joinInitiative()
}

class DropPinDetail: UIView {
    
    weak var delegate: DropPinDelegate?
    
    var hasInitiative = false
    var initiativeKey = ""
        
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!

    @IBAction func startInitiativePressed(_ sender: Any) {
//        if hasInitiative {
//            delegate?.joinInitiative() }
//        else {
            delegate?.startInitiative()
//        }
    }
    
    @IBOutlet weak var startInitiativeButton: UIButton!
    
    var location: DropPinLocation! { //custom class for drop Pin that has location
        didSet {
            addressLabel.text = location.address
            latitudeLabel.text = String(format: "%.2f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.2f", location.coordinate.longitude)
//            :TODO
//            if location.withInitiative {
//               startInitiativeButton.setTitle("Join Initiative?", for: .normal)
//               self.hasInitiative = location.withInitiative
//            } else {
                startInitiativeButton.setTitle("Start an Initiative?", for: .normal)
//            }
    }
    }
    
    required init?(coder aDecoder: NSCoder) { //Create via storyboard
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("DropPinDetail", owner: self, options: nil)
        addSubview(contentView)
    
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    
}

