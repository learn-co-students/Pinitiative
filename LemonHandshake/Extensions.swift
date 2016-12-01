//
//  Extensions.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 11/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let closeLoginVC = Notification.Name("close-login-view-controller")
    static let closeMainVC = Notification.Name("close-main-view-controller")
}


enum StoryboardID: String {
    case loginVC = "login-vc"
//    case navID = "navID"
    case tabBarControl = "tabBarController"
}

