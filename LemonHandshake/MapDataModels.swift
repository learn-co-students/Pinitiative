//
//  MapDataModels.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Mapbox

struct Location {
    var name: String
    var address: String
    var coordinates: CLLocationCoordinate2D
    var longitude: Double { get { return self.coordinates.longitude } }
    var latitude: Double { get { return self.coordinates.latitude } }
    var type: LocationType
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

enum LocationType {
    case school
    case policeStation
    case fireStation
    case park
    case hospital
}
