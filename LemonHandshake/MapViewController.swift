//
//  MapViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import Mapbox
import CoreLocation
import SnapKit

class MapViewController: UIViewController, MGLMapViewDelegate {
    
    @IBAction func myInitiativesButton(_ sender: Any) {
    }
    
    
    var store = MapDataStore.sharedInstance
    var mapView: MGLMapView!
    var mapBounds = MGLCoordinateBounds()
    var locations = [Location]()
//    var landmarkDetailView = LandmarkDetail()
    var selectedAnnotation: CustomPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        store.generateData() //for testing purposes
        
        locations = store.locations //for testing
        addPointAnnotations(locations)
        activateGestureRecognizer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
    
    func createMap() {
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = store.styleURL
        mapView.showsUserLocation = true
        mapView.zoomLevel = 10
        mapView.frame.size.height = view.frame.size.height
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard let userLocation = mapView.userLocation else { return }
        let center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        store.userCoordinate = userLocation.coordinate
        mapView.latitude = 40.771336 //for testing, will change to user location
        mapView.longitude = -73.919845 //for testing, will change to user location
        mapView.setCenter(center, animated: true)
    }
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        
        let selected = annotation as! CustomPointAnnotation
        
        let chosenLocation = Location(name: selected.title!, address: selected.subtitle!, coordinates: selected.coordinate, type: LocationType(rawValue: selected.reuseIdentifier!)!)
        
        performSegue(withIdentifier: "annotationSegue", sender: chosenLocation)
        
        return true
    }
    
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        if let point = annotation as? CustomPointAnnotation,
            let image = point.image,
            let reuseIdentifier = point.reuseIdentifier {
            
            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                // The annotatation image has already been cached, just reuse it.
                return annotationImage
            } else {
                // Create a new annotation image.
                return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
            }
        }
        
        // Fallback to the default marker image.
        return nil
    }
    
    
    func activateGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: nil)
        doubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        mapView.addGestureRecognizer(longPress)
        
    }
    
    func addPointAnnotations(_ locations: [Location]) {
        var pointAnnotations = [CustomPointAnnotation]()
        
        for location in locations {
            let point = CustomPointAnnotation(coordinate: location.coordinates, title: location.name, subtitle: location.address)
            point.image = location.icon
            point.reuseIdentifier = location.type.rawValue
            pointAnnotations.append(point)
            mapView.selectAnnotation(point, animated: false)
        }
        
        mapView.addAnnotations(pointAnnotations)
    }
    
    func handleLongPress(long: UILongPressGestureRecognizer) {
        let longPressLocation: CLLocationCoordinate2D = mapView.convert(long.location(in: mapView), toCoordinateFrom: mapView)
        
        var markedLocations = [Location]()
        
        let markedLocation = Location(name: "Marked Location", address: "Test", coordinates: longPressLocation, type: .custom) //test need GeoFire for Geocoding for addresses
        
        markedLocations.append(markedLocation)
        addPointAnnotations(markedLocations)
        
        performSegue(withIdentifier: "annotationSegue", sender: markedLocation)
    }
}



// MARK: - Segue
extension MapViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "annotationSegue" {
            
            let destVC = segue.destination as! LandmarkDetailViewController
            destVC.location = sender as! Location
        
        } else if segue.identifier == "dropPinSegue" {
            
            let destVC = segue.destination as! DropPinDetailViewController
            destVC.location = sender as! Location
            
        }
        
        
    }
    
}
