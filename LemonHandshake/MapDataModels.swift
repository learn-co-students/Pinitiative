//
//  MapDataModels.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Mapbox

enum LandmarkType {
    case school
    case park
    case hospital
}

protocol Landmark {
    var name: String { get set }
    var coordinates: CLLocationCoordinate2D { get set }
    var type: LandmarkType { get }
    var databaseKey: String { get set }
}

extension Landmark {
    
    var longitude: Double {  return self.coordinates.longitude }
    var latitude: Double { return self.coordinates.latitude }
}

struct Hospital: Landmark {
    var name: String
    var coordinates: CLLocationCoordinate2D
    var type: LandmarkType { return .hospital }
    var databaseKey: String
    var facilityType: String
}

struct Park: Landmark {
    var name: String
    var address: String
    var coordinates: CLLocationCoordinate2D
    var type: LandmarkType { return .park }
    var databaseKey: String
    var acres: Double
}

struct School {
    var name: String
    var address: String
    var coordinates: CLLocationCoordinate2D
    var type: LandmarkType { return .school }
    var databaseKey: String
}


