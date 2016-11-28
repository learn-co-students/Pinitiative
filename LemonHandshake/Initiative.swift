//
//  Initiative.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseDatabase

struct Initiative {
    var name: String
    var shortDescription: String
    var longDescription: String
    
    var databaseKey: String
    
    var leader: String
    var members = [String]()
    var createdAt: Date
    
    var associatedLandmark: Landmark?
    var location: CLLocation
    
    init(name: String, associatedLandmark: Landmark, databaseKey: String, leader: String, shortDescription: String, longDescription: String, createdAt: Date) {
        self.name = name
        self.leader = leader
        self.databaseKey = databaseKey
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.associatedLandmark = associatedLandmark
        self.location = CLLocation(latitude: associatedLandmark.coordinates.latitude, longitude: associatedLandmark.coordinates.longitude)
        self.createdAt = createdAt
    }
    init(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, databaseKey: String, leader: String, shortDescription: String, longDescription: String, createdAt: Date) {
        self.name = name
        self.leader = leader
        self.databaseKey = databaseKey
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.associatedLandmark = nil
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.createdAt = createdAt
    }
}

extension Initiative: CustomStringConvertible {
    var description: String { return name }
    
    static func startNewInitiativeAtLandmark(landmark: Landmark, initiativeName: String, shortDescription: String, longDescription: String) -> Initiative {
        
        let key = FIRDatabase.database().reference().key
        
        let initiative =  Initiative(name: initiativeName, associatedLandmark: landmark, databaseKey: key, leader: FirebaseAuth.currentUserID ?? "", shortDescription: shortDescription, longDescription: longDescription, createdAt: Date())
        
        FirebaseAPI.storeNewInitiative(initiative)
        
        return initiative
    }
}
