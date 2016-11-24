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
    @IBOutlet weak var saveBtn: UIButton!

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
        
        self.checkIfSaved()
    }

    
    func checkIfSaved() {
        
        let _ = DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value, with: { (snapshot) in
            let cookBookId = snapshot.childSnapshot(forPath: "cookBookID").value as! String
            
            DataService.ds.REF_COOKBOOKS.child(cookBookId).child("recipes").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(self.recipe.recipeID) {
                    self.saveBtn.setTitle("SAVED", for: .normal)
                    self.saveBtn.backgroundColor = UIColor.darkGray
                }
            })
            
//     
            
        })
        
    }

        
        
    
  
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sourceBtnTapped(_ sender: Any) {
        
        if let url = URL(string: "\(self.recipe.sourceUrl)") {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func saveRecipe(_ sender: Any) {
        let _ = DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value, with: { (snapshot) in
            let cookBookId = snapshot.childSnapshot(forPath: "cookBookID").value as! String
            
            DataService.ds.REF_COOKBOOKS.child(cookBookId).child("recipes").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(self.recipe.recipeID) {
                    let _ = DataService.ds.REF_COOKBOOKS.child(cookBookId).child("recipes").child(self.recipe.recipeID).removeValue()
                     self.saveBtn.setTitle("SAVE", for: .normal)
                    self.saveBtn.backgroundColor = UIColor(red: 49.0/255.0, green: 69.0/255.0, blue: 157.0/255.0, alpha: 1.0)
                   
                } else {
                    let recipeInfo = [ "ingredients" : self.recipeIngredients,
                                       "recipe_URL" : self.recipe.imageUrl,
                                       "source_URL" : self.recipe.sourceUrl,
                                       "title": self.recipe.title]
                    
                    let _ = DataService.ds.REF_COOKBOOKS.child(cookBookId).child("recipes").child(self.recipe.recipeID).setValue(recipeInfo)
                    self.saveBtn.setTitle("SAVED", for: .normal)
                    self.saveBtn.backgroundColor = UIColor.darkGray
                }
            })
        })
        
    }
    
   
}
