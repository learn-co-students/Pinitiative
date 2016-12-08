//
//  LocationDetailViewController.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: UIViewController, LandmarkDetailDelegate {

    @IBOutlet weak var landmarkDetailView: LandmarkDetail!

    var landmark: Landmark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landmarkDetailView.layer.cornerRadius = 15
        landmarkDetailView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
            view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        landmarkDetailView.nameLabel.text = landmark.name
        if landmark.address.isEmpty {
            landmarkDetailView.addressHeader.isEnabled = false
        } else {
            landmarkDetailView.addressLabel.text = landmark.address
        }
        landmarkDetailView.propertyTypeIcon.image = landmark.tableViewIcon
//        if landmark.type == .school {
//            let school = landmark as! School
//            landmarkDetailView.addressLabel.text = school.address
//            landmarkDetailView.propertyTypeIcon.image = school.icon
//        } else if landmark.type == .park {
//            let park = landmark as! Park
//            landmarkDetailView.addressLabel.text = park.address
//            landmarkDetailView.propertyTypeIcon.image = park.icon
//        } else if landmark.type == .hospital {
//            let hospital = landmark as! Hospital
//            landmarkDetailView.addressLabel.text = "Test address"
//            landmarkDetailView.propertyTypeIcon.image = hospital.icon
//        }
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func startInitiative() {
        performSegue(withIdentifier: Constants.startInitiativeSegue, sender: self.landmark)
    }
    
    func listLandmarkInitiative() {
        //will create another TVC for list of landmarks
        performSegue(withIdentifier: Constants.landmarkInitiativeSegue, sender: self.landmark)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destNC = segue.destination as! UINavigationController
        if segue.identifier == Constants.landmarkInitiativeSegue {
            let destVC = destNC.topViewController as!  LandmarkDetailTableViewController
            destVC.landmark = self.landmark
        } else if segue.identifier == Constants.startInitiativeSegue {
            let destVC = destNC.topViewController as! StartInitiativeNewViewController
            destVC.landmark = self.landmark
        }
    }
}
