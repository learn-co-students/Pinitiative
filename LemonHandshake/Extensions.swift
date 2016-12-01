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
