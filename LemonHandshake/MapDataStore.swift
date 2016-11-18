//
//  MapDataStore.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  MARK: Everything Map Data Related goes here. //fetch dataset
//  should have datapoints

import Foundation
import Mapbox

struct MapDataStore {
    
    static let sharedInstance = MapDataStore()
    
    var userCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D()
        }
        set(newCoordinate) {
            userLatitude = newCoordinate.latitude
            userLongitude = newCoordinate.longitude
        }
    }
    var userLatitude = Double()
    var userLongitude = Double()
    var locations: [Location] = []
    var schools: [School] = []
    var fireStations: [FireStation] = []
    var parks: [Park] = []
    var policeStations: [PoliceStation] = []
    var coordinates: [CLLocationCoordinate2D] = []
    var pointAnnotations: [MGLPointAnnotation] = []
    
   
    var zoomLevel = 0.0
    var styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
    
    private init() { }
    
    
    mutating func generateData() {
        
        //Create dummy schools
        let school1Coordinate = CLLocationCoordinate2D(latitude: 40.771336, longitude: -73.919845)
        coordinates.append(school1Coordinate)
        let school1Location = Location(name: "New Milestone Preschool", address: "Test School", coordinates: school1Coordinate, icon: nil, type: .school )
        self.locations.append(school1Location)
//        let school1 = School(location: school1Location)
//        self.schools.append(school1)
        
        let ps1Coordinate = CLLocationCoordinate2D(latitude: 40.769065, longitude: -73.913325)
        coordinates.append(ps1Coordinate)
        let ps1Location = Location(name: "Police Station", address: "34-16 Astoria Boulevard, Queens, NY 11103", coordinates: ps1Coordinate, icon: nil, type: .policeStation)
        self.locations.append(ps1Location)
//
////        let policeStation = PoliceStation(location: ps1Location)
////        self.policeStations.append(policeStation)
//        
//        
        let fs1Coordinate = CLLocationCoordinate2D(latitude: 40.718249, longitude: -73.83773)
        coordinates.append(fs1Coordinate)
        let fs1Location = Location(name: "Eng.305, Lad.151,", address: "111-02 Queens Blvd.", coordinates: fs1Coordinate, icon: nil, type: .fireStation)
        self.locations.append(fs1Location)
        
//        print(locations)
//        let fireStation = FireStation(location: fs1Location)
//        self.fireStations.append(fireStation)
        
    }
    
        
    func fetchDataSet() {
        
    }
    
}

struct Location {
    var name: String
    var address: String
    var coordinates: CLLocationCoordinate2D
    var longitude: Double { get { return self.coordinates.longitude } }
    var latitude: Double { get { return self.coordinates.latitude } }
    var icon: UIImage!
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






