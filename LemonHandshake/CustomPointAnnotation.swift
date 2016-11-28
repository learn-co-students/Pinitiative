//
//  CustomAnnotation.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Mapbox

// MGLAnnotation protocol reimplementation
class CustomPointAnnotation: NSObject, MGLAnnotation {
    
    // As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    // Custom properties that we will use to customize the annotation's image.
    var image: UIImage?
    var reuseIdentifier: String?
    
    var databaseKey: String
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, databaseKey: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.databaseKey = databaseKey
    }
    
    
    
    
}
