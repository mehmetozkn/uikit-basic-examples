//
//  UploadViewController.swift
//  PhotoShareApp
//
//  Created by Mehmet Özkan on 16.09.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
              
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choseImage))
        view.addGestureRecognizer(imageGestureRecognizer)
    }
    
    
    @objc func choseImage(){
      let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
        
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data) { storagemetedata, error in
                if error != nil {
                    self.buildErrorMessage(titleInput: "Error", messageInput: "Try Again")
                    
                }else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl {
                                
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = [
                                    "imageUrl" : imageUrl,
                                    "comment" : self.textField.text!,
                                    "email" : Auth.auth().currentUser!.email,
                                    "date" : FieldValue.serverTimestamp()
                                ] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) {
                                    (error) in
                                    if error != nil {
                                        self.buildErrorMessage(titleInput: "Error", messageInput: "Try Again Please")
                                        
                                    }else {
                                        self.textField.text = ""
                                        self.imageView.image = UIImage(named: "choose")
                                        self.tabBarController?.selectedIndex = 0
                                        
                                    }
                                }
                                
                            }
                            
                          
                            
                        }
                    }
                }
            }
            
        }
        
    }
    
    func buildErrorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
}
