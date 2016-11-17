//
//  MapDataStore.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import Mapbox

struct MapDataStore {
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var zoomLevel = 0.0
    var styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
    
    static let sharedInstance = MapDataStore()
    private init(){}
    //fetch dataset
    //should have datapoints
    
    
    

}
