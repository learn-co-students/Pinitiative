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
        mapView.zoomLevel = 5
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
        var pointAnnotations = [MGLPointAnnotation]()
        
        let locations = store.locations
        
        for location in locations {
            let point = MGLPointAnnotation() //do not take this out of the for loop! It needs to instantiate a new point everytime it loops.
            point.coordinate = location.coordinates
            point.title = location.name
            point.subtitle = location.address
            pointAnnotations.append(point)
        }
        mapView.addAnnotations(pointAnnotations)
    }

    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        // This example is only concerned with point annotations.
//        guard annotation is MGLPointAnnotation else {
//            return nil
//        }
//
//        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
//        let reuseIdentifier = "\(annotation.coordinate.longitude)"
//        
//        // For better performance, always try to reuse existing annotations.
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//        
//        // If there’s no reusable annotation view available, initialize a new one.
//        if annotationView == nil {
//            annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
//            annotationView!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//            
//            // Set the annotation view’s background color to a value determined by its longitude.
//            let hue = CGFloat(annotation.coordinate.longitude) / 100
//            annotationView!.backgroundColor = UIColor(hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
//        }
        
//        return annotationView
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}

