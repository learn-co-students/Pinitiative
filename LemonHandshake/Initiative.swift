//
//  Initiative.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreLocation

struct Initiative {
    var name: String
    var shortDescription: String
    var longDescription: String
    
    var databaseKey: String
    
    var leader: String
    var members = [String]()
    
    var associatedLandmark: Landmark?
    var location: CLLocation
    
    init(name: String, associatedLandmark: Landmark, databaseKey: String, leader: String, shortDescription: String, longDescription: String) {
        self.name = name
        self.leader = leader
        self.databaseKey = databaseKey
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.associatedLandmark = associatedLandmark
        self.location = CLLocation(latitude: associatedLandmark.coordinates.latitude, longitude: associatedLandmark.coordinates.longitude)
    }
    init(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, databaseKey: String, leader: String, shortDescription: String, longDescription: String) {
        self.name = name
        self.leader = leader
        self.databaseKey = databaseKey
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.associatedLandmark = nil
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
}

extension Initiative: CustomStringConvertible { var description: String { return name } }
