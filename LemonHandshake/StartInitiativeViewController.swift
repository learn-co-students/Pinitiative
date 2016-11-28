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

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    @IBOutlet weak var addInitiativeLabel: UIButton!
    
    @IBOutlet weak var cancelInitiativeLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addInitiativeLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-150)
            make.left.equalTo(self.view).offset(80)
            make.width.equalTo(125)
            addInitiativeLabel.layer.cornerRadius = 20
            addInitiativeLabel.layer.borderColor = UIColor.white.cgColor
            addInitiativeLabel.layer.borderWidth = 1
        }
        
        cancelInitiativeLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-150)
            make.right.equalTo(self.view).offset(-80)
            make.width.equalTo(125)
            cancelInitiativeLabel.layer.cornerRadius = 20
            cancelInitiativeLabel.layer.borderColor = UIColor.white.cgColor
            cancelInitiativeLabel.layer.borderWidth = 1
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(300)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.width.equalTo(300)
            nameTextField.layer.cornerRadius = 20
            nameTextField.layer.borderColor = UIColor.black.cgColor
            nameTextField.layer.borderWidth = 1
        }
        
        descriptionTextField.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(350)
            make.height.equalTo(200)
            make.centerX.equalTo(self.view)
            make.width.equalTo(300)
            descriptionTextField.layer.cornerRadius = 20
            descriptionTextField.layer.borderColor = UIColor.black.cgColor
            descriptionTextField.layer.borderWidth = 1
        }

        datePickerView.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(65)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.8)
           
        }

    }
 
  
    @IBAction func addInitiativeButton(_ sender: Any) {
        
        if descriptionTextField.text != "" && nameTextField.text != "" {
            
            let mapStore = MapDataStore.sharedInstance
            
            Initiative.startNewInitiativeAtLocation(latitude: mapStore.userLatitude, longitude: mapStore.userLongitude, initiativeName: nameTextField.text!, shortDescription: "", longDescription: descriptionTextField.text!)
            
            let alertController = UIAlertController(title: nil, message: "\(nameTextField.text!) added to your initiatives!", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default) { completion -> Void in
                
                print("THE DATE SELECTED IS: \(self.datePickerView.date)")
                
                self.dismiss(animated: true, completion: nil)
                // might need to reload datastore here.
                
            }
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func cancelInitiativeButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
   
    
}
