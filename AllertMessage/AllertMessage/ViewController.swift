//
//  ViewController.swift
//  AllertMessage
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if emailTextField.text == "" {
            createAlert(title: "Error Message", message: "Email is wrong" )
          
            
        }else if passwordTextField.text == ""{
            
            createAlert(title: "Error Message", message: "Password is wrong" )
            
        }else if passwordTextField.text != confirmPasswordTextField.text {
            createAlert(title: "Error Message", message: "Password not match" )

            
        }else{
            createAlert(title: "Congrulations", message: "Login Succesfull" )
            

        }
        
       
        
    }
    
    func createAlert(title: String,  message: String){
        let alertMessage =  UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let oKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
        }
        
        alertMessage.addAction(oKButton)
        self.present(alertMessage, animated: true, completion: nil)
    }
    
}


