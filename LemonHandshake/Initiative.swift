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
    
    var databaseKey: String
    
    var leader: String
    var members = [String]()
    var createdAt: Date
    var associatedDate: Date?
    
    var initiativeDescription: String
    
    var associatedLandmark: Landmark?
    var location: CLLocation
    
    init(name: String, associatedLandmark: Landmark, databaseKey: String, leader: String, initiativeDescription: String, createdAt: Date, associatedDate: Date?) {
        self.name = name
        self.leader = leader
        self.databaseKey = databaseKey
        self.initiativeDescription = initiativeDescription
        self.associatedLandmark = associatedLandmark
        self.location = CLLocation(latitude: associatedLandmark.coordinates.latitude, longitude: associatedLandmark.coordinates.longitude)
        self.createdAt = createdAt
        self.associatedDate = associatedDate
    }
    init(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, databaseKey: String, leader: String, initiativeDescription: String, createdAt: Date, associatedDate: Date?) {
        self.name = name
        self.leader = leader
        self.databaseKey = databaseKey
        self.initiativeDescription = initiativeDescription
        self.associatedLandmark = nil
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.createdAt = createdAt
        self.associatedDate = associatedDate
    }
}

extension Initiative: CustomStringConvertible {
    var description: String { return name }
    
    static func startNewInitiativeAtLandmark(landmark: Landmark, initiativeName: String, initiativeDescription: String, associatedDate: Date?) {
        
        let key = FIRDatabase.database().reference().childByAutoId().key
        
        let initiative =  Initiative(name: initiativeName, associatedLandmark: landmark, databaseKey: key, leader: FirebaseAuth.currentUserID ?? "", initiativeDescription: initiativeDescription, createdAt: Date(), associatedDate: associatedDate)
        
        FirebaseAPI.storeNewInitiative(initiative)
        
    }
    
    static func startNewInitiativeAtLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, initiativeName: String, initiativeDescription: String, associatedDate: Date?) {
        
        let key = FIRDatabase.database().reference().childByAutoId().key
        
        let initiative =  Initiative(name: initiativeName, latitude: latitude, longitude: longitude, databaseKey: key, leader: FirebaseAuth.currentUserID ?? "", initiativeDescription: initiativeDescription, createdAt: Date(), associatedDate: associatedDate)
        
        FirebaseAPI.storeNewInitiative(initiative)
        
    }
}
