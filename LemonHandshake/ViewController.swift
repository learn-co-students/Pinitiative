//
//  ViewController.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let error = FirebaseAuth.signUpUserWith(email: "cboynton16@gmail.com", password: "password")
        if let error = error {
            print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

