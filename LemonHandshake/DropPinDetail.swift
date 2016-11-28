//
//  DropPin.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class DropPinDetail: UIView {
        
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    var location: Location! {
        didSet {
            addressLabel.text = location.address
            latitudeLabel.text = String(location.latitude)
            longitudeLabel.text = String(location.longitude)
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
