//
//  RecipeVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit

class RecipeVC: UIViewController {

    @IBOutlet weak var recipeLbl: UILabel!
    
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeLbl.text = recipe.title
    }

  
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
