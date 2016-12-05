//
//  StartInitiativeNewViewController.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 12/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Former

class StartInitiativeNewViewController: FormViewController {
    
    
    var form = FormManager()
    var formView: UIView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func savePressed(_ sender: UIButton) {
        let isSaved = form.saveInitiative()
        
        if isSaved {
            let alertController = UIAlertController(title: nil, message: "\(form.nameText) added to your initiatives!", preferredStyle: UIAlertControllerStyle.alert)
            
            
            
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default) { completion -> Void in
                
                //                print("THE DATE SELECTED IS: \(self.datePickerView.date)")
                
                self.dismiss(animated: true, completion: nil)
                // might need to reload datastore here.
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            let alertController = UIAlertController(title: nil, message: "Please fill in the required fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var landmarkView: UIView!
    @IBOutlet weak var formerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form.makeStartInitiativeForm()
        formerView.addSubview((form.view)!)
    }
    
}
