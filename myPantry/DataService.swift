//
//  DataService.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-20.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()

let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB REFERENCES
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_BARS = DB_BASE.child("bars")
    private var _REF_COCKTAILS = DB_BASE.child("cocktails")
    private var _REF_COOKBOOKS = DB_BASE.child("cookbooks")
    
    
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_BARS: FIRDatabaseReference {
        return _REF_BARS
    }
    
    var REF_COCKTAILS: FIRDatabaseReference {
        return _REF_COCKTAILS
    }
    
    var REF_COOKBOOKS: FIRDatabaseReference {
        return _REF_COOKBOOKS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        let user = REF_USERS.child(uid!)
        return user
    }
    
    
    
    
    func createFirebaseDbUser(uid: String, userData: Dictionary<String, Any>) {
        // when creating a user, itll create uid, and update the child values with the userData we pass in
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
