//
//  ViewController.swift
//  LayoutProject
//
//  Created by Mehmet Özkan on 1.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    
    @IBOutlet weak var myinput: UILabel!
    var alinanSifre = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view did disappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        myTextField.text = ""
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
    }
    
    
    @IBAction func doControl(_ sender: Any) {
        alinanSifre = myTextField.text!
      
            performSegue(withIdentifier: "toSecondVC", sender: nil )

        
        
    }
    @IBAction func myFunc()
    {
        print("BUtona tıklandı")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSecondVC" {
            let destinationVC = segue.destination as! SecondViewController
            
            destinationVC.myPassword = alinanSifre
        }
    }
    

}

