//
//  Date.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/29/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

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
