//
//  Drink.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-21.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import Firebase

class Drink {
    
    private var _name: String!
    
    var name: String {
        return _name
    }
    
    init(name: String) {
        self._name = name
    }
}
