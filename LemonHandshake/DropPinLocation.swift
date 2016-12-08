//
//  DropPinLocation.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Mapbox
import CoreLocation


struct DropPinLocation {
    
    var coordinate: CLLocationCoordinate2D
    var address: String
    var withInitiative = false
    var initiativeKey = ""
    
    init(coordinate: CLLocationCoordinate2D, address: String) {
        self.coordinate = coordinate
        self.address = address
    }
    
}
