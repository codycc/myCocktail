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

class BarVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var drinkFormView: UIView!
    @IBOutlet weak var addDrinkTextField: UITextField!
    @IBOutlet weak var submitDrinkBtn: UIButton!
    @IBOutlet weak var darkBgView: UIView!
    
    var drinks = [String]()
    var selectedDrinks = [String]()
    var currentUser: User!
    
    override func viewDidLoad() {
        self.selectedDrinks = []
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        addDrinkTextField.delegate = self
        let user = DataService.ds.REF_USER_CURRENT
        print(user)
        
        self.findBarItems()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drink = drinks[indexPath.row]
        selectedDrinks.append(drink)
        print(selectedDrinks)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let drink = drinks[indexPath.row]
        selectedDrinks = selectedDrinks.filter() {$0 != drink }
        print(selectedDrinks)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drink = drinks[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell") as? DrinkCell {
            cell.configureCell(drink: drink)
            return cell
        } else {
            return DrinkCell()
        }
    }
    
    func setCurrentUser() {
        DataService.ds.REF_USER_CURRENT.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? Dictionary<String, AnyObject> {
                let key = snapshot.key
                self.currentUser = User(userKey: key, userData: userDict)
            }
        })
    }
    
    
    func findBarItems() {
        
        
        let _ = DataService.ds.REF_USER_CURRENT.observeSingleEvent( of: .value, with: { (snapshot) in
            let barID = snapshot.childSnapshot(forPath: "barID").value as! String
            print(barID)
            
            let barRef = DataService.ds.REF_BARS.child(barID).child("drinks")
            barRef.observe(.value , with: { (snapshot) in
                self.drinks = []
                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshot {
                        let drink = snap.key
                        self.drinks.append(drink)
                        self.refreshUI()
                      
                    }
                }
            })
           
        })
    }
    
  
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
         return UIModalPresentationStyle.none
    }
    
    func refreshUI() {
        self.tableView.reloadData()
    }
    
    
   
    
    @IBAction func addDrinkTapped(_ sender: Any) {
        drinkFormView.isHidden = false
        addDrinkTextField.isHidden = false
        submitDrinkBtn.isHidden = false
        darkBgView.isHidden = false
    }
    
    @IBAction func submitDrinkTapped(_ sender: Any) {
        drinkFormView.isHidden = true
        addDrinkTextField.isHidden = true
        submitDrinkBtn.isHidden = true
        darkBgView.isHidden = true
        
        let _ = DataService.ds.REF_USER_CURRENT.observeSingleEvent( of: .value, with: { (snapshot) in
            let barID = snapshot.childSnapshot(forPath: "barID").value as! String
            print(barID)
            let drink = self.addDrinkTextField.text!
            let barRef = DataService.ds.REF_BARS.child(barID).child("drinks").child(drink)
            barRef.setValue(true)
            self.view.endEditing(true)
        })
        
        
    }
    
    @IBAction func darkBgTapped(_ sender: Any) {
        drinkFormView.isHidden = true
        addDrinkTextField.isHidden = true
        submitDrinkBtn.isHidden = true
        darkBgView.isHidden = true
        self.view.endEditing(true)

    }

    @IBAction func signoutTapped(_ sender: Any) {
        let removeKeychain: Bool = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("CODY1: ID removed from keychain \(removeKeychain)")
        try! FIRAuth.auth()?.signOut()
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
  
}

