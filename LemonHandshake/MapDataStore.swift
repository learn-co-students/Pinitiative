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

class MapDataStore {
    
    private init() { }
    
    static let sharedInstance = MapDataStore()
    
    var userCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D() { didSet { print("Changed") } }
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    var landmarks: [Landmark] = []
    var coordinates: [CLLocationCoordinate2D] = []
    var pointAnnotations: [MGLPointAnnotation] = []
    
   
    var zoomLevel = 0.0
    var styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
    
}



enum StoryboardID: String {
    case loginVC = "login-vc"
    case navID = "navID"
}



