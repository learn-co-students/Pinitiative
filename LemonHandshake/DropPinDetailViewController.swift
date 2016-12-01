//
//  DropPinDetailViewController.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class DropPinDetailViewController: UIViewController, DropPinDelegate {
    
    @IBOutlet weak var dropPinDetailView: DropPinDetail!
    
    var location: DropPinLocation!
    
    override func viewDidLoad() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGestureRecognizer)
        dropPinDetailView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dropPinDetailView.location = location
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    func startInitiative() {
        performSegue(withIdentifier: Constants.startInitiativeSegue, sender: self.location)
    }

}

