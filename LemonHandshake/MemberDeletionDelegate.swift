//
//  MemberDeletionDelegate.swift
//  LemonHandshake
//
//  Created by Christopher Boynton on 12/7/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

protocol MemberRemovalDelegate {
    func removeUser(withKey key: String)
    func banUser(withKey key: String)
}
