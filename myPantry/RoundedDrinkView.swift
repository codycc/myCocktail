//
//  RoundedDrinkView.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit

class RoundedDrinkView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()

        // How far is spreads / blurs out
       
        // 1 down, 1 up
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 10.0
    }


}
