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

    
//    var mapView: MGLMapView!
    var store = MapDataStore.sharedInstance
    var mapView: MGLMapView!
    var mapBounds = MGLCoordinateBounds()
    var landmarks = [Landmark]()
    var landmarkDetailView = LandmarkDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Map view did load")
        createMap()
        view.addSubview(mapView)
        mapView.delegate = self
        FirebaseAPI.geoFirePullNearbyLandmarks (within: 2) { (landmark) in
            self.addSinglePointAnnotation(for: landmark)
        }
//        addPointAnnotations() //First load
//        activateGestureRecognizer()
        
        
        store.generateData()
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
//        mapView.userTrackingMode = .follow
        mapView.zoomLevel = 10
        mapView.frame.size.height = view.frame.size.height
        view.addSubview(mapView)
        mapView.delegate = self
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
        
        print(landmarks.count)
        for landmark in landmarks {
            if let landmark = landmark as? Park {
                let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.address, databaseKey: landmark.databaseKey)
                point.image = landmark.icon
                point.reuseIdentifier = landmark.type.rawValue
                pointAnnotations.append(point)
            } else if let landmark = landmark as? School {
                let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.address, databaseKey: landmark.databaseKey)
                point.image = landmark.icon
                point.reuseIdentifier = landmark.type.rawValue
                pointAnnotations.append(point)
            } else if let landmark = landmark as? Hospital {
                let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.facilityType, databaseKey: landmark.databaseKey)
                point.image = landmark.icon
                point.reuseIdentifier = landmark.type.rawValue
                pointAnnotations.append(point)
            }
        }
        mapView.addAnnotations(pointAnnotations)
    }
    
    func addSinglePointAnnotation(for landmark: Landmark) {
        
        
        if let landmark = landmark as? Park {
            let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.address, databaseKey: landmark.databaseKey)
            point.image = landmark.icon
            point.reuseIdentifier = landmark.type.rawValue
            mapView.addAnnotation(point)
        } else if let landmark = landmark as? School {
            let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.address, databaseKey: landmark.databaseKey)
            point.image = landmark.icon
            point.reuseIdentifier = landmark.type.rawValue
            mapView.addAnnotation(point)
        } else if let landmark = landmark as? Hospital {
            let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.facilityType, databaseKey: landmark.databaseKey)
            point.image = landmark.icon
            point.reuseIdentifier = landmark.type.rawValue
            mapView.addAnnotation(point)
        }
        
    }


    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        
        let selected = annotation as! CustomPointAnnotation
        
        FirebaseAPI.retrieveLandmark(withKey: selected.databaseKey) { (landmark) in
            OperationQueue.main.addOperation {
                self.performSegue(withIdentifier: "annotationSegue", sender: landmark)
            }
        }
        
        
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
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        mapBounds = mapView.visibleCoordinateBounds
        //landmarks = setVisibleAnnotationsForVisibleCoordinates(mapBounds)
        addPointAnnotations()
    }
    
    func handleSingleTap(tap: UITapGestureRecognizer) {
        landmarkDetailView.removeFromSuperview()
    }
}


// MARK: - Segue
extension MapViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "annotationSegue" {
            
            let destVC = segue.destination as! LandmarkDetailViewController
            
            if let landmark = sender as? School {
                destVC.landmark = landmark
            } else if let landmark = sender as? Hospital {
                destVC.landmark = landmark
            } else if let landmark = sender as? Park {
                destVC.landmark = landmark
            }
        
        }
        
        
        
    }
    
}
