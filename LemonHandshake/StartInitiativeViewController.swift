//
//  StartInitiativeViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import SnapKit

class StartInitiativeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-300)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(150)
            addButtonView.layer.cornerRadius = 20
            addButtonView.layer.borderColor = UIColor.white.cgColor
            addButtonView.layer.borderWidth = 1
        }
        
        cancelButtonView.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-300)
            make.centerX.equalTo(self.view.center)
            make.width.equalTo(150)
            cancelButtonView.layer.cornerRadius = 20
            cancelButtonView.layer.borderColor = UIColor.white.cgColor
            cancelButtonView.layer.borderWidth = 1
        }


    }
    @IBOutlet weak var addButtonView: UIButton!

    @IBOutlet weak var cancelButtonView: UIButton!
    
    @IBAction func addInitiativeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelInitiativeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}
