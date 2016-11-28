//
//  LocationDetailViewController.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {

    @IBOutlet weak var landmarkDetailView: LandmarkDetail!
    var landmark: Landmark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landmarkDetailView.layer.cornerRadius = 15
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        landmarkDetailView.landmark = landmark
    }
    
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

}
