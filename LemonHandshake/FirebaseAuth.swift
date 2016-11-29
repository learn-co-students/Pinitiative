//
//  FirebaseAuth.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 11/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuth {
    
    class func signUpUserWith(email: String, password: String) -> Error? {
        var returnError: Error? = nil
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                returnError = error
            } else {
                FirebaseAPI.storeNewUser(firstName: "Test", lastName: "Name")
            }
        })
        
        return returnError
    }
    
    class func signInUserWith(email: String, password: String) -> Error? {
        var returnError: Error? = nil
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                returnError = error
            }
        })
        
        return returnError
    }
    
    class func signOutUser() -> Error? {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            return error
        }
        
        return nil
    }
    
    class var currentUserID: String? {
        return FIRAuth.auth()?.currentUser?.uid
    }
}
