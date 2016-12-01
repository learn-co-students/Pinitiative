//
//  User.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    
    var databaseKey: String
    
    var initiatives = [String]()
    
    init(firstName:String, lastName: String, databaseKey:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.databaseKey = databaseKey
    }
}


extension User {
    
    //Placeholder blank user value
    static var blank: User {
        return User(firstName: "", lastName: "", databaseKey: "")
    }
}


