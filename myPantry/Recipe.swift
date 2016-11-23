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
    
   
    
    init(recipeData: Dictionary<String, AnyObject>) {
        
        if let title = recipeData["title"] as? String {
            self._title = title
        }
        
        if let recipeID = recipeData["recipe_id"] as? String {
            self._recipeID = recipeID
        }
        
        if let imageUrl = recipeData["image_url"] as? String {
            self._imageUrl = imageUrl
        }
        
    }
    
}
