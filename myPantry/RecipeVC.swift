//
//  RecipeVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Kingfisher

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

}
