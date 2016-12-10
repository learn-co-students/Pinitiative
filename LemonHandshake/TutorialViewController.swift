//
//  TutorialViewController.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 12/9/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var textAreaView: UIView!
    
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(dismissTutorial))
    }
    
    func setUpViews() {
        tutorialView.layer.cornerRadius = 15
        tutorialView.layer.borderWidth = 5
        tutorialView.layer.borderColor = UIColor.themeOrange.cgColor
        
        textAreaView.layer.cornerRadius = 15
        textAreaView.layer.borderWidth = 5
        textAreaView.layer.borderColor = UIColor.black.cgColor
    }
    func dismissTutorial() {
        dismiss(animated: true, completion: nil)
    }
}
