//
//  Extensions.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let closeLoginVC = Notification.Name("close-login-view-controller")
    static let closeMainVC = Notification.Name("close-main-view-controller")
}

enum StoryboardID: String {
    case loginVC = "login-vc"
//    case navID = "navID"
    case tabBarControl = "tabBarController"
}


extension Date {
    func formattedAs(_ string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: self)
    }
    
    func daysInFuture(_ days: Int) -> Date {
        let seconds: TimeInterval = TimeInterval(days * 24 * 60 * 60)
        
        return self.addingTimeInterval(seconds)
    }
}

extension UIView {
    func constrainTo(_ view: UIView, multiplier: CGFloat = 1){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    }
}
