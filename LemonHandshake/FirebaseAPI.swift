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
    
    static var ref: FIRDatabaseReference { return FIRDatabase.database().reference() }
    
    //MARK: - User functions
    static func storeNewUser(id: String, firstName:String, lastName: String) {
        let newUserRef = FIRDatabase.database().reference().child("users").child(id)
        
        let serializedData = [
            "firstName":firstName,
            "lastName":lastName
        ]
        
        newUserRef.updateChildValues(serializedData)
    }
    
    static func retrieveUser(withKey key: String, completion: @escaping (User) -> Void ) {
        let targetUserRef = FIRDatabase.database().reference().child("users").child(key)
        
        targetUserRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { print("FAILURE: Error with snaphsot for user with key: \(key))"); return }
            
            guard
                let firstName = dictionary["firstName"] as? String,
                let lastName = dictionary["lastName"] as? String
                else { print("FAILURE: Could not parse data for user with key: \(key)"); return }
            
            let user = User(firstName: firstName, lastName: lastName, databaseKey: key)
            
            completion(user)
        })
    }
    
    //MARK: - Initiative functions
    static func storeNewInitiative(_ initiative: Initiative) {

        var initiativeRef = FIRDatabase.database().reference().child("initiatives").child(initiative.databaseKey)

        
        var serializedData: [String: Any] = [
            "name": initiative.name,
            "initiativeDescription": initiative.initiativeDescription,
            "latitude": initiative.location.coordinate.latitude,
            "longitude": initiative.location.coordinate.longitude,
            "leader": initiative.leader,
            "members": [initiative.leader:true],
            "createdAt": initiative.createdAt.timeIntervalSince1970,
            "expirationDate": initiative.createdAt.timeIntervalSince1970
        ]
        if let landmarkID = initiative.associatedLandmark?.databaseKey {
            serializedData["landmarkID"] = landmarkID
            
            initiativeRef = initiativeRef.child(landmarkID)

        }
        if let associatedDate = initiative.associatedDate {
            serializedData["associatedDate"] = associatedDate.timeIntervalSince1970
        }
        

        initiativeRef.setValue(serializedData)
        
        
        let userInitiativesRef = FIRDatabase.database().reference().child("users").child(initiative.leader).child("initiatives")
        
        userInitiativesRef.updateChildValues([initiative.databaseKey:true])
        
        if initiative.associatedLandmark == nil {
            FirebaseAPI.geoFireStoreNewInitiative(at: initiative.location, key: initiative.databaseKey)
        }
    }
    
    static func archive(initiative: Initiative) {
        
        //Easier access to the initiative key
        let initiativeKey = initiative.databaseKey
        
        //Create the ref for the old location of the initiative data
        let targetInitiativeRef = FIRDatabase.database().reference().child("initiatives").child(initiativeKey)
        
        //Create the ref for the new location of the initiative data in the archive section
        let archivedInitiativeRef = FIRDatabase.database().reference().child("archive").child("initiatives").child(initiativeKey)
        
        //Create the ref for the GeoFire location of the initiative, if it has one.
        var geofireRef: FIRDatabaseReference? = nil
        
        //Create the ref for the chat
        var chatRef = FIRDatabase.database().reference().child("Chats").child(initiativeKey)
        
        if initiative.associatedLandmark == nil {
            geofireRef = FIRDatabase.database().reference().child("geofire").child(initiativeKey)
        }
        
        //Get the data located at the old location
        targetInitiativeRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            //Convert the snaphot value to a usable dictionary
            guard let dictionary = snapshot.value as? [String:Any] else { print("FAILURE: Error with snapshot for archiving initiative with key: \(initiativeKey)"); return }
            
            //Take the member info out of the main dictionary
            guard let members = dictionary["members"] as? [String: Bool] else { print("FAILURE: Could not retrieve members for while archiving initiative with key: \(initiativeKey)"); return }
            
            //Iterate over the members
            for member in members {
                
                //If that member is still a member of the initiative...
                if member.value == true {
                    
                    //...create an easy access variable...
                    let userKey = member.key
                    
                    //...find the ref for the user in firebase...
                    let userRef = FIRDatabase.database().reference().child("users").child(userKey)
                    
                    //...and set the value for the initiative to false in the intiative section of their info
                    userRef.child("initiatives").updateChildValues([initiativeKey:false])
                }
            }
            
            //Put the dictionary into the new location for the archive
            archivedInitiativeRef.setValue(dictionary)
            
            //Once everything is complete, delete the info from the old location...
            targetInitiativeRef.removeValue(completionBlock: { (error, ref) in
                print("WARNING: Initiative \(initiative.name) with key \(initiativeKey) has expired and has been archived")
                if let error = error {
                    print(error.localizedDescription)
                }
            })
            
            //...remove the info from the GeoFire location, should it exist...
            if let geofireRef = geofireRef {
                geofireRef.removeValue(completionBlock: { (error, ref) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                })
            }
            
            //...and remove the chat from the database
            chatRef.removeValue(completionBlock: { (error, ref) in
                if let error = error {
                    print(error.localizedDescription)
                }
            })
        })
        
        
    }
    
    static func retrieveInitiative(withKey key: String, completion: @escaping (Initiative)-> Void ) {
        let targetInitiativeRef = FIRDatabase.database().reference().child("initiatives").child(key)
        
        targetInitiativeRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { print("FAILURE: Error with snapshot for initiative with key: \(key)"); return }
            
            guard
                let name = dictionary["name"] as? String,
                let initiativeDescription = dictionary["initiativeDescription"] as? String,
                let latitude = dictionary["latitude"] as? Double,
                let longitude = dictionary["longitude"] as? Double,
                let leader = dictionary["leader"] as? String,
                let members = dictionary["members"] as? [String:Any],
                let createdAt = dictionary["createdAt"] as? TimeInterval,
                let expirationDate = dictionary["expirationDate"] as? TimeInterval
                else { print("FAILURE: Could not parse data for initiative with key: \(key)");return }
            
            if Date() > Date(timeIntervalSince1970: expirationDate).daysInFuture(30) {
            }
            
            
            let associatedDate: Date? = Date(optionalTimeIntervalSince1970: (dictionary["associatedDate"] as? TimeInterval) ?? nil)

            
            if let landmark = dictionary["landmark"] as? String {
                FirebaseAPI.retrieveLandmark(withKey: landmark, completion: { (landmark) in
                    var initiative = Initiative(name: name, associatedLandmark: landmark, databaseKey: key, leader: leader, initiativeDescription: initiativeDescription, createdAt: Date(timeIntervalSince1970: createdAt), associatedDate: associatedDate, expirationDate: Date(timeIntervalSince1970: expirationDate))
                    
                    for member in members {
                        initiative.members.append(member.key)
                    }
                    
                    completion(initiative)
                })
            } else {
                var initiative = Initiative(name: name, latitude: latitude, longitude: longitude, databaseKey: key, leader: leader, initiativeDescription: initiativeDescription, createdAt: Date(timeIntervalSince1970: createdAt), associatedDate: associatedDate, expirationDate: Date(timeIntervalSince1970: expirationDate))
                for member in members {
                    initiative.members.append(member.key)
                }
                completion(initiative)
            }
            
        })
    }
    
    static func newMemberForInitiative(memberKey: String, initiativeKey: String) {
        let membersRef = FIRDatabase.database().reference().child("initiatives").child(initiativeKey).child("members")
        
        membersRef.setValue(true, forKey: memberKey)
    }
    
    static func retrieveInitiativesFor(userKey: String, completion: @escaping ([Initiative]) -> Void) {
        let userInitiativeRef = FIRDatabase.database().reference().child("users").child(userKey).child("initiatives")
        
        userInitiativeRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any] {
                
                var initiativeKeys = [String]()
                var initiatives = [Initiative]()
                
                for item in dictionary {
                    initiativeKeys.append(item.key)
                }
                
                for initiativeKey in initiativeKeys {
                    FirebaseAPI.retrieveInitiative(withKey: initiativeKey, completion: { (initiative) in
                        initiatives.append(initiative)
                        if initiativeKeys.count == initiatives.count {
                            completion(initiatives)
                        }
                    })
                }
                
            } else {
                print("No initiatives for user")
            }
        })
        
    }
    
    //MARK: - Landmark functions
    static func retrieveLandmark(withKey key: String, completion: @escaping (Landmark)->Void ) {
        let targetLandmarkRef = FIRDatabase.database().reference().child("landmarks").child(key)
        
        targetLandmarkRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: String] else { print("FAILURE: Error with snapshot for landmark with key: \(key)");return }
            guard let type = dictionary["type"] else { print("FAILURE: Could not retrieve landmark type for landmark with key: \(key)"); return }
            
            switch type {
            case "hospital":
                guard
                    let name = dictionary["name"],
                    let facilityType = dictionary["facilityType"],
                    let latitudeString = dictionary["latitude"],
                    let latitude = Double(latitudeString),
                    let longitudeString = dictionary["longitude"],
                    let longitude = Double(longitudeString)
                    else { print("FAILURE: Could not parse data for landmark with key: \(key)"); return}
                
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
                    else { print("FAILURE: Could not parse data for landmark with key: \(key)"); return }
                
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                let park = Park(name: name, address: address, coordinates: coordinates, databaseKey: key, acres: acres)
                
                completion(park)
            
            default:
                print("FAILURE: Could not recognize type \"\(type)\" for landmark with key: \(key)")
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

extension Date {
    init?(optionalTimeIntervalSince1970: TimeInterval?) {
        if let timeIntervalSince1970 = optionalTimeIntervalSince1970 {
            self = Date(timeIntervalSince1970: timeIntervalSince1970)
        } else {
            return nil
        }
    }
}
