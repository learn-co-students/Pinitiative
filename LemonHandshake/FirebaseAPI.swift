//
//  FirebaseAPI.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

class FirebaseAPI {
    private init() {}
    
    //MARK: - User functions
    static func storeNewUser(firstName:String, lastName: String) {
        let newUserRef = FIRDatabase.database().reference().child("users").childByAutoId()
        
        let serializedData = [
            "firstName":firstName,
            "lastName":lastName
        ]
        
        newUserRef.updateChildValues(serializedData)
    }
    
    static func retrieveUser(withKey key: String, completion: @escaping (User) -> Void ) {
        let targetUserRef = FIRDatabase.database().reference().child("users").child(key)
        
        targetUserRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: String] else { print("FAILURE: Error with snaphsot for user with key: \(key))"); return }
            
            guard
                let firstName = dictionary["firstName"],
                let lastName = dictionary["lastName"]
                else { print("FAILURE: Could not parse data for user with key: \(key)"); return }
            
            let user = User(firstName: firstName, lastName: lastName, databaseKey: key)
            
            completion(user)
        })
    }
    
    //MARK: - Initiative functions
    static func storeNewInitiative(_ initiative: Initiative) {
        let initiativeRef = FIRDatabase.database().reference().child("initiatives")
        
        var serializedData: [String: Any] = [
            "name": initiative.name,
            "shortDescription": initiative.shortDescription,
            "longDescription": initiative.longDescription,
            "latitude": initiative.location.coordinate.latitude,
            "longitude": initiative.location.coordinate.longitude,
            "leader": initiative.leader
        ]
        if let landmarkID = initiative.associatedLandmark?.databaseKey {
            serializedData["landmarkID"] = landmarkID
        }
        
        initiativeRef.setValue(serializedData, forKey: initiative.databaseKey)
    }
    
    static func retrieveInitiative(withKey key: String, completion: @escaping (Initiative)-> Void ) {
        let targetInitiativeRef = FIRDatabase.database().reference().child("initiatives").child(key)
        
        targetInitiativeRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { print("FAILURE: Error with snapshot for initiative with key: \(key)"); return }
            
            guard
                let name = dictionary["name"] as? String,
                let shortDescription = dictionary["shortDescription"] as? String,
                let longDescription = dictionary["longDescription"] as? String,
                let latitude = dictionary["latitude"] as? Double,
                let longitude = dictionary["longitude"] as? Double,
                let leader = dictionary["leader"] as? String,
                let members = dictionary["members"] as? [String:Any]
                else { print("FAILURE: Could not parse data for initiative with key: \(key)");return }
            
            var initiative = Initiative(name: name, latitude: latitude, longitude: longitude, databaseKey: key, leader: leader, shortDescription: shortDescription, longDescription: longDescription)
            
            for member in members {
                initiative.members.append(member.key)
            }
            
            completion(initiative)
        })
    }
    
    static func newMemberForInitiative(memberKey: String, initiativeKey: String) {
        let membersRef = FIRDatabase.database().reference().child("initiatives").child(initiativeKey).child("members")
        
        membersRef.setValue(true, forKey: memberKey)
    }
    
    //MARK: - Landmark functions
    static func retrieveLandmark(withKey key: String, completion: @escaping (Landmark)->Void ) {
        let targetLandmarkRef = FIRDatabase.database().reference().child("landmarks").child(key)
        
        targetLandmarkRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: String] else { print("FAILURE: Error with snapshot for location with key: \(key)");return }
            guard let type = dictionary["type"] else { print("FAILURE: Could not retrieve location type for location with key: \(key)"); return }
            
            switch type {
            case "hospital":
                guard
                    let name = dictionary["name"],
                    let facilityType = dictionary["facilityType"],
                    let latitudeString = dictionary["latitude"],
                    let latitude = Double(latitudeString),
                    let longitudeString = dictionary["longitude"],
                    let longitude = Double(longitudeString)
                    else { print("FAILURE: Could not parse data for location with key: \(key)"); return}
                
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                let hospital = Hospital(name: name, coordinates: coordinates, databaseKey: key, facilityType: facilityType)
                
                completion(hospital)
            case "park":
                guard
                    let name = dictionary["name"],
                    let address = dictionary["address"],
                    let acresString = dictionary["acres"],
                    let acres = Double(acresString),
                    let latitudeString = dictionary["latitude"],
                    let latitude = Double(latitudeString),
                    let longitudeString = dictionary["longitude"],
                    let longitude = Double(longitudeString)
                    else { print("FAILURE: Could not parse data for location with key: \(key)"); return }
                
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                let park = Park(name: name, address: address, coordinates: coordinates, databaseKey: key, acres: acres)
                
                completion(park)
            
            default:
                print("FAILURE: Could not recognize type \"\(type)\" for location with key: \(key)")
            }
            
        })
    }
    
    //MARK: - Report based functions
    static func reportLandmark(for landmarkKey: String, by userKey: String, report: String) {
        let reportRef = FIRDatabase.database().reference().child("reports").child("landmarks").child(landmarkKey).childByAutoId()
        
        let serializedReportInfo = ["reportBy": userKey, "report": report]
        
        reportRef.updateChildValues(serializedReportInfo)
    }
    
    static func reportLocation(for location: CLLocation, by userKey: String, report: String) {
        let reportRef = FIRDatabase.database().reference().child("reports").child("locations").childByAutoId()
        
        let serializedReportInfo = ["reportBy": userKey, "report": report]
        
        reportRef.updateChildValues(serializedReportInfo)
    }
    
    static func reportUser(targetUserID: String, from originUserID: String, report: String) {
        let reportRef = FIRDatabase.database().reference().child("reports").child("users").child(targetUserID).childByAutoId()
        
        let serializedReportInfo = ["reportBy": originUserID, "report": report]
        
        reportRef.updateChildValues(serializedReportInfo)
    }
    
    
}
