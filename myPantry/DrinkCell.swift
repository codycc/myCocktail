//
//  DrinkCell.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit

class DrinkCell: UITableViewCell {
    
    @IBOutlet weak var drinkLbl: UILabel!

    func configureCell(drink: String) {
        print(drink)
        drinkLbl.text = drink.capitalized
    }
    
  

}
