//
//  TutorialViewController.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 12/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpContainer()
        
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(dismissTutorial))
    }
    
    func setUpContainer() {
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 5
        containerView.layer.borderColor = UIColor.themeOrange.cgColor
    }
    func dismissTutorial() {
        dismiss(animated: true, completion: nil)
    }
}
