//
//  GeoFire.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreLocation
import GeoFire
import FirebaseDatabase
import FirebaseAuth

extension FirebaseAPI {
    
    typealias Kilometers = Double
    
    //static let ref: FIRDatabaseReference { return FIRDatabase.database().reference() }
    
    static func geoFirePullNearbyLandmarks(within range: Kilometers, ofLocation location: CLLocation, completion: @escaping (Landmark)->Void) {
        var geoFireRef: FIRDatabaseReference { return FirebaseAPI.ref.child("geofire") }
        
        //Property sets
        let store = MapDataStore.sharedInstance
        
        let userLocation = location
        
        print("LOCATION: \(store.userCoordinate)")
        
        guard let geoFire = GeoFire(firebaseRef: geoFireRef) else { print("FAILURE: GeoFire failed to create non nil value from geoFireRef"); return }
        //
        
        //Make Circle Query
        guard let circleQuery = geoFire.query(at: userLocation, withRadius: range) else { print("FAILURE: Failed to create non nil value for cicleQuery"); return }
        
        circleQuery.observe(.keyEntered) { (optionalKey, location) in
            guard let key = optionalKey else { print("FAILURE: Failed to retrieve key during circleQuery observe"); return }
            
            
            FirebaseAPI.retrieveLandmark(withKey: key, completion: { (landmark) in
                print("SUCCESS: Retrieved data for \(landmark.name)")
                store.landmarks.append(landmark)
                
                completion(landmark)
            })
        }
    }
    
    static func geoFireStoreNewInitiative(at location: CLLocation, key: String) {
        let geoFireRef: FIRDatabaseReference = FirebaseAPI.ref.child("geofire").child("initiatives")
        
        guard let geoFire = GeoFire(firebaseRef: geoFireRef) else { print("FAILURE: Geofire failed to create non nil value from geoFireRef"); return }
        
        geoFire.setLocation(location, forKey: key)
        
    }
    
    static func geoFirePullNearbyInitiatives(within range: Kilometers, ofLocation location: CLLocation, completion: @escaping (Initiative)->Void ) {
        print("TEST")
        
        print("PROGRESS: Pulling Nearby initiatives")
        let geoFireRef: FIRDatabaseReference = FirebaseAPI.ref.child("geofire").child("initiatives")
        
        guard let geoFire = GeoFire(firebaseRef: geoFireRef) else { print("FAILURE: GeoFire failled co reate non nil value from geoFireRef"); return }
        
        guard let circleQuery = geoFire.query(at: location, withRadius: range) else { print("FAILURE: Failed to create non nil value for circleQuery"); return }
    
        circleQuery.observe(.keyEntered) { (optionalKey, location) in
            
            guard let key = optionalKey else { print("FAILURE: Failed to retrieve key during circleQuery observe"); return }
            print("PROGRESS: Pulling Nearby initiative with key: \(key)")
            
            FirebaseAPI.retrieveInitiative(withKey: key, completion: { (initiative) in
                completion(initiative)
            })
        }
        
    }
}
