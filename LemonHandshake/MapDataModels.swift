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



class Landmark {
    
    var address: String
    var agency: String
    var borough: String
    var latitude: Double
    var longitude: Double
    var name: String
    var useDescription: String
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var databaseKey: String
    var icon: UIImage {
        
        switch self.agency {
        
        case "EDU", "CUNY", "ACS", "EDUC", "HRA", "NYPL"/*NYpublibrary*/:
            return UIImage(named: "school")!
        case "FIRE":
            return UIImage(named: "firemen")!
        case "PARKS", "SANIT", "DEP":
            return UIImage(named: "forest")!
        case "NYPD","NYCHA", "COURT", "DCAS", "DOT", "ACS", "CORR":
            return UIImage(named: "police")!
        case "HLTH", "DHS", "HHC", "AGING", "OCME", "HRA":
            return UIImage(named: "hospital-building")!
        case "other":
            let image = UIImage(named: "Logo")!
            
            let iconSize = CGSize(width: 20, height: 20)
            
            image.size.equalTo(iconSize)
            
            return image
        default:
            let image = UIImage(named: "Logo")!
//
//            let iconSize = CGSize(width: 20, height: 20)
//            
//            image.size.equalTo(iconSize)
            
            return image
        }
    }
    
    //JCB tableViewIcon: New! Dec 7, 2016
    var tableViewIcon: UIImage {
        switch self.agency {
        case "EDU", "CUNY", "ACS", "EDUC", "HRA", "NYPL"/*NYpublibrary*/:
            return UIImage(named: "schoolTableViewIcon")!
        case "FIRE":
            return UIImage(named: "fireTruckTableViewIcon")!
        case "PARKS", "SANIT", "DEP":
            return UIImage(named: "parkTableViewIcon")!
        case "NYPD","NYCHA", "COURT", "DCAS", "DOT", "ACS", "CORR":
            return UIImage(named: "policeTableViewIcon")!
        case "HLTH", "DHS", "HHC", "AGING", "OCME", "HRA":
            return UIImage(named: "hospitalTableViewIcon")!
        case "other":
            return UIImage(named: "CustomLandmarkTableViewIcon")!
        default:
            return UIImage(named: "CustomLandmarkTableViewIcon")!
        }

    }
    
    
   
    init(address: String, agency: String, borough: String, latitude: Double, longitude: Double, name: String, useDescription: String, databaseKey: String){
        
        self.address = address
        self.agency = agency
        self.borough = borough
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.useDescription = useDescription
        self.databaseKey = databaseKey
        
    }
}






enum LocationType: String {
    case EDUC = "school"
    case policeStation = "policeStation"
    case fireStation = "fireStation"
    case park = "park"
    case hospital = "hospital"
}
