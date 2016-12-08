
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
    var shouldPullGeofire: Bool = true
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var searchMapLabel: UIButton!
    
    @IBAction func userLocationEnabled(_ sender: UIButton) {
        mapView.showsUserLocation = true
    }
    
    @IBOutlet weak var userLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shouldPullGeofire = true
        
        createMap()
        activateGestureRecognizer()
        mapView.delegate = self
        setMapSearchButtonConstraints()
        setUserLocationArrowConstraints()
//        addAnnotationToMarkedLocations() TODO
        self.view.bringSubview(toFront: userLocationButton)
        
        let imageView = UIImageView(image: IconConstants.fullLogo)
        navBar.titleView = imageView
        navBar.titleView?.layer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45)
        navBar.titleView?.contentMode = .scaleAspectFit
        
        shouldPresentNewUserInfo()
        
    }
    
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        
        if String(format:"%.5f", mapView.centerCoordinate.latitude) != String(format:"%.5f", store.userLocation.coordinate.latitude) {
            
            searchMapLabel.isEnabled = true
            searchMapLabel.isHidden = false
            
            mapView.showsUserLocation = false
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Map functions
    func createMap() {
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = store.styleURL
        mapView.showsUserLocation = true
        mapView.zoomLevel = 13.7
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
        if shouldPullGeofire {
            addAnnotationToMarkedLocations()
            refreshMapLandmarks()
            shouldPullGeofire = false
        }
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        mapBounds = mapView.visibleCoordinateBounds
        addPointAnnotations()
        
    }
    
    func setUserLocationArrowConstraints() {
        userLocationButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).multipliedBy(1.83)
            make.centerY.equalTo(self.view).multipliedBy(0.33)
            
            make.width.equalTo(30)
            make.height.equalTo(30)
            
            userLocationButton.layer.borderWidth = 1
            userLocationButton.alpha = 1.0
            userLocationButton.layer.cornerRadius = 6
            userLocationButton.backgroundColor = UIColor.themeBlue.withAlphaComponent(0.5)
        }
    }
    
    
    // MARK: Refresh Landmarks
    func refreshMapLandmarks(){
        self.store.landmarks.removeAll()
        self.landmarks.removeAll()
        
        if !shouldPullGeofire { //JCB removed other refresh landmark function
            if let annotations = mapView.annotations {
                mapView.removeAnnotations(annotations) }
        }
        
//       addAnnotationToMarkedLocations() TODO
        FirebaseAPI.geoFirePullNearbyLandmarks (within: 1.0, ofLocation: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)) { (landmark) in
            OperationQueue.main.addOperation {
                self.store.landmarks.append(landmark)
                self.addSinglePointAnnotation(for: landmark)
            }
        }
        
        
    }
    
    //MARK: JCB Refresh marked locations
    func addAnnotationToMarkedLocations() {
        
        //GeoFire location then pull initiatives and add notations for them.
        FirebaseAPI.geoFirePullNearbyInitiatives(within: 1.0, ofLocation: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude), completion: { (initiative) in
            //Use landmark class to instantiate the value for point annotation
            
            if initiative.associatedLandmark == nil {
                let markedLocation = Landmark(address: "Marked Location", agency: "other", borough: "test", latitude: initiative.location.coordinate.latitude, longitude: initiative.location.coordinate.longitude, name: initiative.name, useDescription: "test", databaseKey: "test")
                OperationQueue.main.addOperation {
                    self.store.landmarks.append(markedLocation)
                    self.addSinglePointAnnotation(for: markedLocation)
                }
            }
        })
    }
    
    
    // MARK: Annotations
    func addPointAnnotations() {
        var pointAnnotations = [CustomPointAnnotation]()
        
        for landmark in landmarks {
            let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.address, databaseKey: landmark.databaseKey, image: landmark.icon)
            
            var id: String {
                switch landmark.agency {
                case "EDU", "CUNY", "ACS", "EDUC", "HRA", "NYPL"/*NYpublibrary*/:
                    return "school"
                    
                case "FIRE":
                    return "firemen"
                    
                case "PARKS", "SANIT", "DEP":
                    return "forest"
                    
                case "NYPD","NYCHA", "COURT", "DCAS", "DOT", "ACS", "CORR":
                    return "police"
                    
                case "HLTH", "DHS", "HHC", "AGING", "OCME", "HRA":
                    return "hospital-building"
                    
                default:
                    return "drop_pin_marker"
                }
                
            }
            point.reuseIdentifier = id
            
            // point.reuseIdentifier = landmark.type.rawValue
            pointAnnotations.append(point)
            
        }
        mapView.addAnnotations(pointAnnotations)
        
    }
    
    func addSinglePointAnnotation(for landmark: Landmark) {
        
        let point = CustomPointAnnotation(coordinate: landmark.coordinates, title: landmark.name, subtitle: landmark.address, databaseKey: landmark.databaseKey, image: landmark.icon)
        
        var id: String {
            switch landmark.agency {
            case "EDU", "CUNY", "ACS", "EDUC", "HRA", "NYPL"/*NYpublibrary*/:
                return "school"
                
            case "FIRE":
                return "firemen"
                
            case "PARKS", "SANIT", "DEP":
                return "forest"
                
            case "NYPD","NYCHA", "COURT", "DCAS", "DOT", "ACS", "CORR":
                return "police"
                
            case "HLTH", "DHS", "HHC", "AGING", "OCME", "HRA":
                return "hospital-building"
                
            default:
                return "drop_pin_marker"
            }
            
        }
        print("THIS IS THE POINTS AGENCY CONVERTED INTO AN ICON STRING\(id)")
        point.reuseIdentifier = id
        
        print("THIS IS THE Agency \(landmark.agency)")
        
        mapView.addAnnotation(point)
    }
    
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        
        let selected = annotation as! CustomPointAnnotation
        var geocodeAddress = ""
        
        if selected.reuseIdentifier != Constants.customMarkerText {
            FirebaseAPI.retrieveLandmark(withKey: selected.databaseKey) { (landmark) in
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: Constants.annotationSegueText, sender: landmark)
                }
            }
        } else {
            let location = CLLocation(latitude: selected.coordinate.latitude, longitude: selected.coordinate.longitude)
            
            var hasInitiative = false
            var initiativeKey = ""
            
            //Check if the location has a saved initiative already.
            FirebaseAPI.geoFirePullNearbyInitiatives(within: 1.0, ofLocation: location, completion: { (initiative) in
                hasInitiative = true
                initiativeKey = initiative.databaseKey
                
                self.geocoder.reverseGeocodeLocation(location){
                    placemarks, error in
                    var address = String()
                    
                    if error != nil {
                        address = "Cannot convert coordinate to address."
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
                }
                
                var dropPinLocation = DropPinLocation(coordinate: selected.coordinate, address: geocodeAddress)
                dropPinLocation.withInitiative = hasInitiative
                dropPinLocation.initiativeKey = initiativeKey
                //TODO: Check if user is part of the initiative
                OperationQueue.main.addOperation {
                    self.performSegue(withIdentifier: Constants.dropPinSegueText, sender: dropPinLocation)
                }
            })
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
        
        
        // MARK: Gesture Recognizer functions
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
                    address = "Cannot convert coordinate to address."
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
                
                let image = UIImage(named: "drop_pin_marker")!
                
                let iconSize = CGSize(width: 20, height: 20)
                
                image.size.equalTo(iconSize)
                
                
                let markedLocation = CustomPointAnnotation(coordinate: longPressCoordinate, title: Constants.markedLocationText, subtitle: geocodeAddress, databaseKey: "", image: image)
                
                
                markedLocation.reuseIdentifier = Constants.customMarkerText
                self.mapView.addAnnotation(markedLocation)
                
                let senderLocation = DropPinLocation(coordinate: longPressCoordinate, address: geocodeAddress)
                
                
                
                self.performSegue(withIdentifier: Constants.dropPinSegueText, sender: senderLocation)
            }
        }
        
        @IBAction func searchMapButton(_ sender: Any) {
            print("SEARCHING FOR NEW LOCATIONS")
            refreshMapLandmarks()
        }
        
        func setMapSearchButtonConstraints() {
            searchMapLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.view)
                make.centerY.equalTo(self.view).multipliedBy(0.33)
                make.width.equalTo(200)
                make.height.equalTo(45)
                searchMapLabel.backgroundColor = UIColor.themeBlue.withAlphaComponent(0.5)
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
                print(segue.identifier)
                let destVC = segue.destination as! LandmarkDetailViewController
                
                if let landmark = sender {
                    destVC.landmark = landmark as! Landmark
                }
            }
            
            if segue.identifier == Constants.dropPinSegueText {
                print(segue.identifier)
                let destVC = segue.destination as! DropPinDetailViewController
                destVC.location = sender as! DropPinLocation
            }
        }
        
        //MARK: - Test For New User Screen
        func shouldPresentNewUserInfo() {
            FirebaseAPI.test(forUserWithKey: FirebaseAuth.currentUserID) { (doesExist) in
                if !doesExist {
                    self.present(NewUserInfoViewController(), animated: true)
                }
            }
        }
}
