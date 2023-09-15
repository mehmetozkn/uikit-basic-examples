//
//  ViewController.swift
//  UserDefaultsProject
//
//  Created by Mehmet Özkan on 14.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldNote: UITextField!
    @IBOutlet weak var textFieldWhen: UITextField!
    @IBOutlet weak var labelWhen: UILabel!
    @IBOutlet weak var labelWork: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedNote = UserDefaults.standard.object(forKey: "not")
        let savedWhen = UserDefaults.standard.object(forKey: "zaman")
        
       
        if let gelenNot = savedNote as? String {
            
            labelWork.text = "Work : \(gelenNot)"
        }
        
        if let gelenZaman = savedWhen as? String {
            labelWhen.text = "When : \(gelenZaman)"
        }
        
        
    }

    @IBAction func butonSave(_ sender: Any) {
        UserDefaults.standard.set(textFieldNote.text!, forKey: "not")
        
        UserDefaults.standard.set(textFieldWhen.text!, forKey: "zaman")
        
        labelWork.text = "Work : \(textFieldNote.text!)"
        labelWhen.text = "When : \(textFieldWhen.text!)"
    }
    
    @IBAction func butonDelete(_ sender: Any) {
        
        let savedNote = UserDefaults.standard.object(forKey: "not")
        let savedWhen = UserDefaults.standard.object(forKey: "zaman")
        
        if(savedNote as? String != nil){
            UserDefaults.standard.removeObject(forKey: "not")
            labelWork.text = "Work : "
        }
        
        if(savedWhen as? String != nil){
            UserDefaults.standard.removeObject(forKey: "zaman")
            labelWhen.text = "When : "
        }
    }
    
}

