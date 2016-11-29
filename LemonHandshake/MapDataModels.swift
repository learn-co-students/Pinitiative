//
//  MapDataModels.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Mapbox
import UIKit


enum LandmarkType: String {
    case school = "School"
    case park = "Park"
    case hospital = "Hospital"
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
    
    var icon: UIImage {
        switch type {
//        case .fireStation:
//            return UIImage(named: "firemen")!
        case .school:
            return UIImage(named: "school")!
        case .park:
            return UIImage(named: "forest")!
//        case .policeStation:
//            return UIImage(named: "police")!
        case .hospital:
        return UIImage(named: "hospital-building")!
    }
 }
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

struct School: Landmark {
    var name: String
    var address: String
    var coordinates: CLLocationCoordinate2D
    var type: LandmarkType { return .school }
    var databaseKey: String
}


enum LocationType: String {
    case school = "school"
    case policeStation = "policeStation"
    case fireStation = "fireStation"
    case park = "park"
    case hospital = "hospital"
}
