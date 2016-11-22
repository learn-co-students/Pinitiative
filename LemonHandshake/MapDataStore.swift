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
        let school1Location = Location(name: "New Milestone Preschool", address: "Test School", coordinates: school1Coordinate, type: .school )
        self.locations.append(school1Location)
//        let school1 = School(location: school1Location)
//        self.schools.append(school1)
        
        let ps1Coordinate = CLLocationCoordinate2D(latitude: 40.769065, longitude: -73.913325)
        coordinates.append(ps1Coordinate)
        let ps1Location = Location(name: "Police Station", address: "34-16 Astoria Boulevard, Queens, NY 11103", coordinates: ps1Coordinate, type: .policeStation)
        self.locations.append(ps1Location)
//
////        let policeStation = PoliceStation(location: ps1Location)
////        self.policeStations.append(policeStation)
//        
//        
        let fs1Coordinate = CLLocationCoordinate2D(latitude: 40.718249, longitude: -73.83773)
        coordinates.append(fs1Coordinate)
        let fs1Location = Location(name: "Eng.305, Lad.151,", address: "111-02 Queens Blvd.", coordinates: fs1Coordinate, type: .fireStation)
        self.locations.append(fs1Location)
        
//        print(locations)
//        let fireStation = FireStation(location: fs1Location)
//        self.fireStations.append(fireStation)
        
        
        let school2Coordinate = CLLocationCoordinate2D(latitude: 40.7692629, longitude: -73.9230771)
        coordinates.append(fs1Coordinate)
        let school2Location = Location(name: "Discover Lane Daycare", address: "Won't tell you", coordinates: school2Coordinate, type: .school)
        self.locations.append(school2Location)
        
        let hs1Coordinate = CLLocationCoordinate2D(latitude: 40.7682454, longitude: -73.9248465)
        let hs1Location = Location(name: "Mount Sinai Hospital", address: "25-10 30th Avenue Astoria, NY 11102", coordinates: hs1Coordinate, type: .hospital)
        self.locations.append(hs1Location)
        
        let parkCoordinate = CLLocationCoordinate2D(latitude: 40.7796684, longitude: -73.9215888)
        let parkLocation = Location(name: "Astoria Park", address: "Somewhere beside the water", coordinates: parkCoordinate, type: .park)
        self.locations.append(parkLocation)
        
        
        let park2Coordinate = CLLocationCoordinate2D(latitude: 40.778848, longitude: -73.968898)
        let park2Location = Location(name: "Central Park", address: "In Manhattan", coordinates: park2Coordinate, type: .park)
        self.locations.append(park2Location)
        
    }
    
        
    func fetchDataSet() { //From Firebase woot!
        
    }
    
}



enum StoryboardID: String {
    case loginVC = "login-vc"
    case mainVC = "mapVC"
}



