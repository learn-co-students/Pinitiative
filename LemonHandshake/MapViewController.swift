//
//  MapViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
//        activateGestureRecognizer()
        // Do any additional setup after loading the view.
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
        mapView.longitude = -73.974187 //Dummy Data. Will change to user location
        mapView.latitude = 40.771133
        mapView.zoomLevel = 14
        mapView.styleURL = MGLStyle.streetsStyleURL(withVersion: 9)
        let coordinate: CLLocationCoordinate2D = mapView.centerCoordinate
        addPointAnnotation(coordinate: coordinate)
        view.addSubview(mapView)
        mapView.delegate = self
    }

    func activateGestureRecognizer() {
        // double tapping zooms the map, so ensure that can still happen
        let doubleTap = UITapGestureRecognizer(target: self, action: nil)
        doubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTap)
        
        // delay single tap recognition until it is clearly not a double
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTap.require(toFail: doubleTap)
        mapView.addGestureRecognizer(singleTap)
    }
    
    func handleSingleTap(tap: UIGestureRecognizer) {
        // convert tap location (CGPoint)
        // to geographic coordinates (CLLocationCoordinate2D)
        let location: CLLocationCoordinate2D = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
        print("You tapped at: \(location.latitude), \(location.longitude)")
        
        
//        // create an array of coordinates for our polyline
//        let coordinates: [CLLocationCoordinate2D] = [mapView.centerCoordinate, location]
        
    }
    
    func addPointAnnotation(coordinate: CLLocationCoordinate2D) {
        let point = MGLPointAnnotation()
        point.coordinate = (coordinate)
        point.title = "\(coordinate.latitude), \(coordinate.longitude)"
        print(point)
        mapView.addAnnotation(point)
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    // Or, if you’re using Swift 3 in Xcode 8.0, be sure to add an underscore before the method parameters:
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
}

