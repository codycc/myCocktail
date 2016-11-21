//
//  FridgeVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-18.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class BarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func signoutTapped(_ sender: Any) {
        let removeKeychain: Bool = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("CODY1: ID removed from keychain \(removeKeychain)")
        try! FIRAuth.auth()?.signOut()
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
  
}

