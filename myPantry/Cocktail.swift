//
//  Cocktail.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-21.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import Firebase

class Cocktail {
    private var _name: String!
    private var _cocktailID: String!
    private var _category: String!
    private var _instructions: String!
    private var _cocktailURL: String!
    private var _ingredients: Array<String>!
    private var _stirMeasures: Array<String>!
    
    var name: String {
        return _name
    }
    
    var cocktailID: String {
        return _cocktailID
    }
    
    var category: String {
        return _category
    }
    
    var instructions: String {
        return _instructions
    }
    
    var cocktailURL: String {
        return _cocktailURL
    }
    
    var ingredients: Array<String> {
        return _ingredients
    }
    
    var stirMeasures: Array<String> {
        return _stirMeasures
    }
    
    init(name: String, cocktailID: String) {
        self._name = name
        self._cocktailID = cocktailID
    }
    
    init(cocktailID: String, cocktailData: Dictionary<String, AnyObject>) {
        self._cocktailID = cocktailID
        
        if let name = cocktailData["strDrink"] as? String {
            self._name = name
        }
        
        if let category = cocktailData["strCategory"] as? String {
            self._category = category
        }
        
        if let instructions = cocktailData["strInstructions"] as? String {
            self._instructions = instructions
        }
        
        if let cocktailURL = cocktailData["strDrinkThumbs"] as? String {
            self._cocktailURL = cocktailURL
        }
      //BREAK
        
    }
    
}
