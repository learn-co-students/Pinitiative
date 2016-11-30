//
//  InitiativeDetailViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Foundation
import SnapKit


class InitiativeDetailViewController: UIViewController {

    @IBOutlet weak var InitiativeNameLabel: UILabel!
    
    @IBOutlet weak var dateStartedLabel: UILabel!
    
    @IBOutlet weak var leaderLabel: UILabel!
    
    @IBOutlet weak var leaderTextLabel: UILabel!
    
    @IBOutlet weak var totalFollowersLabel: UILabel!
    
    @IBOutlet weak var aboutThisInitiativeLabel: UILabel!
    
    @IBOutlet weak var dateTextLabel: UILabel!
    
    @IBOutlet weak var followersTextLabel: UILabel!
    
    @IBOutlet weak var descriptionTextHere: UILabel!
    
    @IBOutlet weak var chatButtonLabel: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImage(named: "purpleBenches" )
        let imageView = UIImageView(image: background)
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.5
        view.sendSubview(toBack: imageView)
        
        InitiativeNameLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(50)
            make.centerX.equalTo(self.view)
            make.width.equalTo(400)

        }
        
        dateStartedLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(30)
            make.width.equalTo(200)

        }
        
        dateTextLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(100)
            make.right.equalTo(self.view).offset(-30)
            make.width.equalTo(200)

        }
        
        leaderLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(130)
            make.left.equalTo(self.view).offset(30)
            make.width.equalTo(200)

        }
        
        leaderTextLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(130)
            make.right.equalTo(self.view).offset(-30)
            make.width.equalTo(200)

        }
        
        totalFollowersLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(160)
            make.left.equalTo(self.view).offset(30)
            make.width.equalTo(200)

        }
        followersTextLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(160)
            make.right.equalTo(self.view).offset(-30)
            make.width.equalTo(200)

        }
        
        aboutThisInitiativeLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(200)
            make.centerX.equalTo(self.view)
            make.width.equalTo(400)

        }
        
        descriptionTextHere.snp.makeConstraints { (make) in
            make.topMargin.equalTo(self.view).offset(225)
            make.centerX.equalTo(self.view)
            make.width.equalTo(400)
            make.height.equalTo(225)
            descriptionTextHere.layer.cornerRadius = 20
            descriptionTextHere.layer.borderColor = UIColor.black.cgColor
            descriptionTextHere.layer.borderWidth = 1

        }
        
        chatButtonLabel.snp.makeConstraints { (make) in
            make.bottomMargin.equalTo(self.view).offset(-75)
            make.width.equalTo(200)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
            chatButtonLabel.layer.cornerRadius = 20
            chatButtonLabel.layer.borderColor = UIColor.black.cgColor
            chatButtonLabel.layer.borderWidth = 1
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chatButtonSegue" {
            let dest = segue.destination as? ChatDetailViewController
            dest?.initiative =
        }
    }
    

}
