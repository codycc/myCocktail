//
//  SignInVC.swift
//  myPantry
//
//  Created by Cody Condon on 2016-11-21.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: RoundField!
    @IBOutlet weak var passwordField: RoundField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("CODY1: Email user athenticated with firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("CODY: Unable to authenticate with Firebase using Email")
                        } else {
                            print("CODY: Successfully signed up with Firebase")
                            if let user = user {
                              let userData = ["provider" : user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                            
                        }
                    })
                    
                }
            })
        }
    }
    
    
    func completeSignIn(id: String, userData: Dictionary<String,Any>) {
        DataService.ds.createFirebaseDbUser(uid: id, userData: userData)
        
        let keyChainResult: Bool = KeychainWrapper.standard.set(id, forKey: "uid")
    }


 

}
