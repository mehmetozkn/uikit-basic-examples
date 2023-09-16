//
//  ViewController.swift
//  PhotoShareApp
//
//  Created by Mehmet Özkan on 16.09.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                authdataresult, error in
                if error != nil {
                    self.buildErrorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try Again")
                    
                }else {
                    self.performSegue(withIdentifier: "toFeedVC" , sender: nil)
                }
            }
            
        }else {
            buildErrorMessage(titleInput: "Error!", messageInput: "Enter Email and Password")
            
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil {
                    self.buildErrorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Try Again")
                    
                }else {
                    self.performSegue(withIdentifier: "toFeedVC" , sender: nil)
                }
            }
            
        }else {
            buildErrorMessage(titleInput: "Error!", messageInput: "Enter Email and Password")
            
        }
        
       
    }
    
    
    func buildErrorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
}

