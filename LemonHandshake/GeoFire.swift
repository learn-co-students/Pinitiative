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
    
    static func geoFirePullNearbyLandmarks(within range: Kilometers, ofLocation location: CLLocation, completion: @escaping (Landmark)->Void) {
        
        
        //Property sets
        let mapStore = MapDataStore.sharedInstance
        
        let ref = FIRDatabase.database().reference()
        let geoFireRef = ref.child("geofire")
        
        let userLocation = location
        print("LOCATION: \(mapStore.userCoordinate)")
        
        
        guard let geoFire = GeoFire(firebaseRef: geoFireRef) else { print("FAILURE: GeoFire failed to create non nil value from geoFireRef"); return }
        
        
        //Make Circle Query
        guard let circleQuery = geoFire.query(at: userLocation, withRadius: range) else { print("FAILURE: Failed to create non nil value for cicleQuery"); return }
        
        print("PROGRESS: Got here")
        circleQuery.observe(.keyEntered) { (optionalKey, location) in
            print("PROGRESS: Circle Query Observing")
            guard let key = optionalKey else { print("FAILURE: Failed to retrieve key during circleQuery observe"); return }
            print("PROGRESS: Circle Query Observing location with key: \(key)")
            
            
            FirebaseAPI.retrieveLandmark(withKey: key, completion: { (landmark) in
                print("SUCCESS: Retrieved data for \(landmark.name)")
                mapStore.landmarks.append(landmark)
                
                completion(landmark)
            })
        }
        
       
        
        
    }
}
