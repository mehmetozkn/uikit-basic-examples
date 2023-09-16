//
//  SettingsViewController.swift
//  PhotoShareApp
//
//  Created by Mehmet Özkan on 16.09.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutButton(_ sender: Any) {
        do {
            try  Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            
        }
        
        
      
   
    }
    
}
