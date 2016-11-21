//
//  User.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-20.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    private var _username: String!
    private var _provider: String!
    private var _userKey: String!
    private var _barID: String!
    private var _userRef: FIRDatabaseReference!
    
    var username: String {
        return _username
    }
    
    var provider: String {
        return _provider
    }
    
    var userKey: String {
        return _userKey
    }
    
    var barID: String {
        return _barID
    }
    
    init(username: String, provider: String, barId: String) {
        self._username = username
        self._provider = provider
        self._barID = barID
    }
    
    init(userKey: String, userData: Dictionary<String, AnyObject>) {
        self._userKey = userKey
        
        if let username = userData["username"] as? String {
            self._username = username
        }
        
        if let provider = userData["provider"] as? String {
            self._provider = provider
        }
        
        if let barID = userData["barID"] as? String {
            self._barID = barID
        }
        
        _userRef = DataService.ds.REF_USERS.child(_userKey)
    }
}
