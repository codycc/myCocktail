//
//  Bar.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import Firebase


class Bar {
    private var _userId: String!
    private var _barKey: String!
    private var _drinks: Dictionary<String, AnyObject>
    private var _barRef: FIRDatabaseReference!
    
    init(barKey: String, barData: Dictionary<String, AnyObject>) {
        self._barKey = barKey
        
        if let userId = barData["userId"] as? String {
            self._userId = userId
        }
        
        if let drinks = barData["drinks"] as? Dictionary<String, AnyObject> {
            self._drinks = drinks
        }
        
        _barRef = DataService.ds.REF_BARS.child(barKey)
    }
    
  
    
}
