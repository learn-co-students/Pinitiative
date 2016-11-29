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
}
