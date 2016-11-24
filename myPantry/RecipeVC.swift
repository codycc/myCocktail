//
//  RecipeVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class RecipeVC: UIViewController {
    @IBOutlet weak var recipeImg: UIImageView!

    @IBOutlet weak var recipeLbl: UILabel!
    @IBOutlet weak var ingredientLbl: UITextView!
    
    var recipe: Recipe!
    var recipeInformation: [Any]!
    var recipeIngredients: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // unpacking the array for use
        recipe = recipeInformation.last as! Recipe!
        // removing the original recipe info since the needed information is parsed, the array contains new detailed recipe information
        let count = recipeInformation.count
        recipeInformation.remove(at: count - 1)
        
        print("here \(recipeInformation)")
        for ingredient in recipeInformation! {
            recipeIngredients = "\(recipeIngredients) \(ingredient)"
        }
        
        //setting url from original info
        let url = URL(string: recipe.imageUrl)
        recipeImg.kf.setImage(with: url)
        
        ingredientLbl.text = recipeIngredients
        
        print("here is the string containing ingredients \(recipeIngredients)")
        recipeLbl.text = recipe.title
    }

  
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveRecipe(_ sender: Any) {
        let _ = DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value, with: { (snapshot) in
            let cookBookId = snapshot.childSnapshot(forPath: "cookBookID").value as! String
            
            print("here is cookbookID: \(cookBookId)")
          
            let recipeInfo = [ "ingredients" : self.recipeIngredients,
                               "recipe_URL" : self.recipe.imageUrl,
                               "source_URL" : self.recipe.sourceUrl,
                               "title": self.recipe.title]
            
            let _ = DataService.ds.REF_COOKBOOKS.child(cookBookId).child("recipes").childByAutoId().setValue(recipeInfo)
         
        })
        
    
        
    }
}
