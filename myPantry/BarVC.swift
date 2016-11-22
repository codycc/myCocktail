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

class BarVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var drinkFormView: UIView!
    @IBOutlet weak var addDrinkTextField: UITextField!
    @IBOutlet weak var submitDrinkBtn: UIButton!
    @IBOutlet weak var darkBgView: UIView!
    
    var drinks = [String]()
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drink = drinks[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell") as? DrinkCell {
            cell.configureCell(drink: drink)
            return cell
        } else {
            return DrinkCell()
        }
    }
    
    
    func findBarItems() {
        self.drinks = []
        let _ = DataService.ds.REF_USER_CURRENT.observeSingleEvent( of: .value, with: { (snapshot) in
            let barID = snapshot.childSnapshot(forPath: "barID").value as! String
            print(barID)
            
            let barRef = DataService.ds.REF_BARS.child(barID).child("drinks")
            barRef.observeSingleEvent( of: .value, with: { (snapshot) in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == "showForm"{
                let popoverViewController = segue.destination
                
                popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
                popoverViewController.popoverPresentationController!.delegate = self
         
               
            }
        
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
    }
    
    @IBAction func darkBgTapped(_ sender: Any) {
        drinkFormView.isHidden = true
        addDrinkTextField.isHidden = true
        submitDrinkBtn.isHidden = true
        darkBgView.isHidden = true

    }

    @IBAction func signoutTapped(_ sender: Any) {
        let removeKeychain: Bool = KeychainWrapper.standard.removeObject(forKey: "uid")
        print("CODY1: ID removed from keychain \(removeKeychain)")
        try! FIRAuth.auth()?.signOut()
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }
  
}

