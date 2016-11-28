//
//  MapDataModels.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Mapbox
import UIKit


struct Location {
    var name: String
    var address: String
    var coordinates: CLLocationCoordinate2D
    var longitude: Double { get { return self.coordinates.longitude } }
    var latitude: Double { get { return self.coordinates.latitude } }
    var type: LocationType
    var icon: UIImage {
        switch type {
        case .fireStation:
        return UIImage(named: "firemen")!
        case .school:
        return UIImage(named: "school")!
        case .park:
        return UIImage(named: "forest")!
        case .policeStation:
        return UIImage(named: "police")!
        case .hospital:
        return UIImage(named: "hospital-building")!
        case .custom:
        return UIImage(named: "drop_pin_marker")!
        }
    }


    init(name: String, address: String, coordinates: CLLocationCoordinate2D, type: LocationType) {
        self.name = name
        self.address = address
        self.coordinates = coordinates
        self.type = type
    }
    
}

struct School { //other custom fields for schools, add here. If there are other fields, add them in the initializer
    var location: Location!
    
    init(location: Location) {
        self.location = location
    }
    
}

struct PoliceStation {
    var location: Location!
}

struct FireStation {
    var location: Location!
}

struct Park {
    var location: Location!
}

enum LocationType: String {
    case school = "school"
    case policeStation = "policeStation"
    case fireStation = "fireStation"
    case park = "park"
    case hospital = "hospital"
    case custom = "custom"
}
