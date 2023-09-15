//
//  ViewController.swift
//  calculator
//
//  Created by Mehmet Özkan on 28.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var secontLbl: UITextField!
    @IBOutlet weak var firstLbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cikar(_ sender: Any) {
        if let ilkSayi = Int(firstLbl.text!){
            if let ikinciSayi = Int(secontLbl.text!){
                let result = ilkSayi - ikinciSayi
                resultLbl.text = String(result)
            }
        }
    }
    @IBAction func topla(_ sender: Any) {
        if let ilkSayi = Int(firstLbl.text!){
            if let ikinciSayi = Int(secontLbl.text!){
                let result = ilkSayi + ikinciSayi
                resultLbl.text = String(result)
            }
        }
    }
    
}

