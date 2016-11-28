//
//  DropPinDetailViewController.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class DropPinDetailViewController: UIViewController {

    var location: Location!
    override func viewDidLoad() {
        
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        landmarkDetailView.location = location
    }
    
    func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}