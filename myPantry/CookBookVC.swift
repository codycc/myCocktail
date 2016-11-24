//
//  CookBookVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-24.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Firebase

class CookBookVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recipes: [Recipe]!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.findCookBookItems()

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        print("here is recipe \(recipe.recipe_URL)")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as? RecipeCell {
           cell.configureCell(recipe: recipe)
           return cell
        } else {
           return RecipeCell()
        }
    
   
    }
    
    func findCookBookItems() {
         self.recipes = []
        let _ = DataService.ds.REF_USER_CURRENT.observeSingleEvent( of: .value, with: { (snapshot) in
            let cookBookID = snapshot.childSnapshot(forPath: "cookBookID").value as! String
            print(cookBookID)
            
            let cookBookRef = DataService.ds.REF_COOKBOOKS.child(cookBookID).child("recipes")
            cookBookRef.observe(.value , with: { (snapshot) in

                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshot {
                        if let data = snap.value as? Dictionary<String,AnyObject> {
                            let recipeKey = snap.key
                            let recipe = Recipe(recipeKey: recipeKey, recipeData: data)
                            self.recipes.append(recipe)
                            print("here is recipe\(recipe.recipe_URL)")
                        
                        }
                    }
                }
            })
        })

    }
    
    

    

}
