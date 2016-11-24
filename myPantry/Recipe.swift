//
//  Recipe.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-21.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import Foundation
import Firebase

class Recipe {
    private var _publisher: String!
    private var _title: String!
    private var _sourceUrl: String!
    private var _recipeID: String!
    private var _imageUrl: String!
    private var _socialRank: Int!
    private var _ingredients: String!
    private var _recipe_URL: String!
  
    
    var publisher: String {
        return _publisher
    }
    
    var title: String {
        return _title
    }
    
    var sourceUrl: String {
        return _sourceUrl
    }
    
    var recipeID: String {
        return _recipeID
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var socialRank: Int {
        return _socialRank
    }
    
    var ingredients: String {
        return _ingredients
    }
    
    var recipe_URL: String {
        return _recipe_URL
    }
   
    
    init(recipeKey: String? = nil, recipeData: Dictionary<String, AnyObject>) {
        self._recipeID = recipeKey
        // from api
        if let title = recipeData["title"] as? String {
            self._title = title
        }
        
        if let recipeID = recipeData["recipe_id"] as? String {
            self._recipeID = recipeID
        }
        
        if let imageUrl = recipeData["image_url"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let sourceUrl = recipeData["source_url"] as? String {
            self._sourceUrl = sourceUrl
        }
        
        // from firebase
        if let ingredients = recipeData["ingredients"] as? String {
            self._ingredients = ingredients
        }
        
        if let recipe_URL = recipeData["recipe_URL"] as? String {
            self._recipe_URL = recipe_URL
        }
        
    }
    
   
    
}
