//
//  MemberManagementViewController.swift
//  LemonHandshake
//
//  Created by Tameika Lawrence on 11/15/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class MemberManagementViewController: UIViewController {
    
    let myURL = Bundle.main.url(forResource: "calendarHTML", withExtension: "html")
    
    @IBOutlet weak var calendarWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let background = UIImage(named: "leafyRailroad")
        let imageView = UIImageView(image: background)
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.5
        view.sendSubview(toBack: imageView)

        let requestObj = NSURLRequest(url: myURL!)
        
        
        calendarWebView.snp.makeConstraints { (make) in
            make.width.equalTo(415)
            make.height.equalTo(310)
            make.centerX.equalTo(self.view)
            make.topMargin.equalTo(self.view).offset(15)
            
        }
        
        calendarWebView.loadRequest(requestObj as URLRequest)
        
    }
    
}


