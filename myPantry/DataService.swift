//
//  DataService.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-20.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = FIRDatabase.database().reference()

let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB REFERENCES
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_BARS = DB_BASE.child("bars")
    private var _REF_COCKTAILS = DB_BASE.child("cocktails")
    
    
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_BARS: FIRDatabaseReference {
        return _REF_BARS
    }
    
    var REF_COCKTAILS: FIRDatabaseReference {
        return _REF_COCKTAILS
    }
}
