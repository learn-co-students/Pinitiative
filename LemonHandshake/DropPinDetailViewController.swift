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
        dropPinDetailView.layer.cornerRadius = 15
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
    
    func joinInitiative() {
        FirebaseAPI.userJoin(initiativeWithKey: self.location.initiativeKey)
        
        let alertController = UIAlertController(title: nil, message: "You have been aadded to this initiative!", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.default) { completion -> Void in
        
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

