//
//  ResultsVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit


class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recipes = [Recipe]()
    
    
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
                if let recipe = sender as? Recipe {
                    recipeVC.recipe = recipe
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
        let recipe = recipes[indexPath.row]
        performSegue(withIdentifier: "goToRecipeVC", sender: recipe)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
