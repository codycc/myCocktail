//
//  ResultsVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Alamofire

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recipes = [Recipe]()
    var ingredientsArray = [Any]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("IM AT RESULTS VC AND HERE ARE THE RECIPES ARRAY \(recipes)")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRecipeVC" {
            if let recipeVC = segue.destination as? RecipeVC {
                if let recipeInfo = sender as? [Any] {
                    recipeVC.recipeInformation = recipeInfo
                }
            }
        }

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as? ResultCell {
            cell.configureCell(recipe: recipe)
            return cell
        } else {
            return ResultCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeInfo = recipes[indexPath.row]
        
        let id = recipeInfo.recipeID
        
        let alamoString = "\(FOOD_URL)get?\(API_KEY)&rId=\(id)"
        print("here is alamostring\(alamoString)")
        Alamofire.request(alamoString).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let recipe = dict["recipe"] as? Dictionary<String, AnyObject> {
                    if let ingredients = recipe["ingredients"] as? [String] {
                        for ingredient in ingredients {
                          self.ingredientsArray.append(ingredient)
                        print(ingredient)
                        }
                        self.ingredientsArray.append(recipeInfo)
                    }
                }
             
            }
            self.performSegue(withIdentifier: "goToRecipeVC", sender: self.ingredientsArray)
            print(self.ingredientsArray)
            self.ingredientsArray = []
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
