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
    
  
    
    var store = MapDataStore.sharedInstance
    var mapView: MGLMapView!
    var mapBounds = MGLCoordinateBounds()
    var landmarks = [Landmark]()
    var geocoder = CLGeocoder()
    
    @IBOutlet weak var searchMapLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
        view.addSubview(mapView)
        activateGestureRecognizer()
        mapView.delegate = self
        setMapSearchButtonConstraints()
        
        

    }

    
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
    
        if String(format:"%.5f", mapView.centerCoordinate.latitude) != String(format:"%.5f", store.userLocation.coordinate.latitude) {
            
            searchMapLabel.isEnabled = true
            searchMapLabel.isHidden = false
   
        }

    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Navigation
    
    
    func refreshLandmarks(){
        self.store.landmarks.removeAll()
        self.landmarks.removeAll()
        FirebaseAPI.geoFirePullNearbyLandmarks (within: 1.0, ofLocation: CLLocation(latitude: store.userLatitude, longitude: store.userLongitude)) { (landmark) in
            self.store.landmarks.append(landmark)
            self.addSinglePointAnnotation(for: landmark)
        }
    }
    
    func refreshMapLandmarks(){
        print("Refreshing Landmarks")
        self.store.landmarks.removeAll()
        self.landmarks.removeAll()
        //JCB unwrap annotations to prevent from crashing that if there are annotations.
//        guard let annotations = mapView.annotations else { return }
//        self.mapView.removeAnnotations(annotations)
        self.mapView.removeAnnotations(mapView.annotations!)
        FirebaseAPI.geoFirePullNearbyLandmarks (within: 1.0, ofLocation: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)) { (landmark) in
            self.store.landmarks.append(landmark)
            self.addSinglePointAnnotation(for: landmark)
        }
    }
    
    func createMap() {
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = store.styleURL
        mapView.showsUserLocation = true
        mapView.zoomLevel = 12
        mapView.frame.size.height = view.frame.size.height
        view.addSubview(mapView)
        mapView.delegate = self
        
    }
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard let userLocation = mapView.userLocation else { return }
        let center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        store.userCoordinate = userLocation.coordinate
        store.userLatitude = userLocation.coordinate.latitude
        store.userLongitude = userLocation.coordinate.longitude
        mapView.latitude = userLocation.coordinate.latitude
        mapView.longitude = userLocation.coordinate.longitude
        mapView.setCenter(center, animated: true)
        print("LOCATION: Coordinate\(store.userCoordinate) should equal \(userLocation.coordinate)")
        refreshLandmarks()
        
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
        
        if selected.reuseIdentifier != Constants.customMarkerText {
            FirebaseAPI.retrieveLandmark(withKey: selected.databaseKey) { (landmark) in
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: Constants.annotationSegueText, sender: landmark)
                }
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
    
    
    func activateGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: nil)
        doubleTap.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(doubleTap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        mapView.addGestureRecognizer(longPress)
        
    }
    
    func handleLongPress(long: UILongPressGestureRecognizer) {
        let longPressCoordinate: CLLocationCoordinate2D = mapView.convert(long.location(in: mapView), toCoordinateFrom: mapView)
        var geocodeAddress = String()
        
        let location = CLLocation(latitude: longPressCoordinate.latitude, longitude: longPressCoordinate.longitude)
        
        
        geocoder.reverseGeocodeLocation(location){
            placemarks, error in
            var address = String()
            
                if error != nil {
                    geocodeAddress = "Cannot convert coordinate to address."
                }
                
                guard let unwrappedPlacemarks = placemarks else { return }
                if unwrappedPlacemarks.count > 0 {
                    let placemark = unwrappedPlacemarks[0]
                    let addressLines = placemark.addressDictionary?["FormattedAddressLines"] as! [String]
                    for addressLine in addressLines {
                        address += (addressLine + " ")
                    }
                    geocodeAddress = address
                }
        
            let markedLocation = CustomPointAnnotation(coordinate: longPressCoordinate, title: Constants.markedLocationText, subtitle: geocodeAddress, databaseKey: "")
            //test need geocoding for mapbox
            markedLocation.reuseIdentifier = Constants.customMarkerText
            self.mapView.addAnnotation(markedLocation)
            
            let senderLocation = DropPinLocation(coordinate: longPressCoordinate, address: geocodeAddress)
            
            self.performSegue(withIdentifier: Constants.dropPinSegueText, sender: senderLocation)
    
        }
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        mapBounds = mapView.visibleCoordinateBounds
        //landmarks = setVisibleAnnotationsForVisibleCoordinates(mapBounds)
        addPointAnnotations()
    }
    
    
    
    @IBAction func searchMapButton(_ sender: Any) {
        print("HEEEEY")
        refreshMapLandmarks()
        
    }
    
    func setMapSearchButtonConstraints() {
            searchMapLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.33)
            make.width.equalTo(200)
            make.height.equalTo(45)
            searchMapLabel.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            searchMapLabel.layer.borderWidth = 1
            searchMapLabel.layer.cornerRadius = 20
        }
        self.view.bringSubview(toFront: searchMapLabel)
        searchMapLabel.isEnabled = false
        searchMapLabel.isHidden = true
      
    }
    
}




// MARK: - Segue
extension MapViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.annotationSegueText {
            
            let destVC = segue.destination as! LandmarkDetailViewController
            
            if let landmark = sender as? School {
                destVC.landmark = landmark
            } else if let landmark = sender as? Hospital {
                destVC.landmark = landmark
            } else if let landmark = sender as? Park {
                destVC.landmark = landmark
            }
            
            
        } else if segue.identifier == Constants.dropPinSegueText {
            
            let destVC = segue.destination as! DropPinDetailViewController
            destVC.location = sender as! DropPinLocation
            
        }
    }
    
}
