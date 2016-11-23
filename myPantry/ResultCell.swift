//
//  ResultCell.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Kingfisher

class ResultCell: UITableViewCell {
    @IBOutlet weak var recipeImg: UIImageView!

    @IBOutlet weak var recipeNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(recipe: Recipe) {
        let url = URL(string: recipe.imageUrl)
        recipeImg.kf.setImage(with: url)
        recipeNameLbl.text = recipe.title
    }
    

}
