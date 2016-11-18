//
//  MapViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Mapbox
import CoreLocation

class MapViewController: UIViewController, MGLMapViewDelegate {
    
//    var mapView: MGLMapView!
    var store = MapDataStore.sharedInstance
    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        view.addSubview(mapView)
        mapView.delegate = self
        store.generateData()
        addPointAnnotations()
//        activateGestureRecognizer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createMap() {
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = store.styleURL
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.zoomLevel = 10
        mapView.frame.size.height = view.frame.size.height * 0.93
    }
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard let userLocation = mapView.userLocation else { return }
        let center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        store.userCoordinate = userLocation.coordinate
        mapView.latitude = 40.771336
        mapView.longitude = -73.919845
        mapView.setCenter(center, animated: true)
    }
    
    
    func addPointAnnotations() {
        var pointAnnotations = [CustomPointAnnotation]()
        
        let locations = store.locations
        
        for location in locations {
            let point = CustomPointAnnotation(coordinate: location.coordinates, title: location.name, subtitle: location.address)
            
            switch location.type {
            case .fireStation:
                point.image = UIImage(named: "firemen")
                point.reuseIdentifier = "fireStation"
            case .school:
                point.image = UIImage(named: "school")
                point.reuseIdentifier = "school"
            case .park:
                point.image = UIImage(named: "forest")
                point.reuseIdentifier = "park"
            case .policeStation:
                point.image = UIImage(named: "police")
                point.reuseIdentifier = "policeStation"
            case .hospital:
                point.image = UIImage(named: "hospital-building")
                point.reuseIdentifier = "hospital"
            }
            
            pointAnnotations.append(point)
        }
        mapView.addAnnotations(pointAnnotations)
    }

    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
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
}
