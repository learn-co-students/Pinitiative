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
    
    class func signOutUser() -> Error? {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            return error
        }
        
        return nil
    }
    
    class var currentUserID: String {
        return FIRAuth.auth()?.currentUser?.uid ?? "ERROR_NO_USER"
    }
}
