//
//  ResultsVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-22.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {

    var recipes = [Recipe]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("IM AT RESULTS VC AND HERE ARE THE RECIPES ARRAY \(recipes)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
