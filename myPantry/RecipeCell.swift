//
//  RecipeCell.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-24.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(recipe: Recipe) {
        let url = URL(string: recipe.recipe_URL)
           recipeImg.kf.setImage(with: url)
        
//       
//       //
//         recipeLbl.text = recipe.title
//        
        
        
    }

}
