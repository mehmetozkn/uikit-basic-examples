//
//  DetailsViewController.swift
//  ShoppingStoreAppCoreData
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var selectedProduct = ""
    var selectedUUID : UUID?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedProduct != "" {
            
            saveButton.isHidden = true
            
            if let uuidString = selectedUUID?.uuidString {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Shopping")
                fetchRequest.predicate = NSPredicate(format: "id = %@" , uuidString)
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let results = try context.fetch(fetchRequest)
                    
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "name") as? String {
                                nameTextField.text = name
                            }
                            
                            if let price = result.value(forKey: "price") as? Int {
                                priceTextField.text = String(price)
                            }
                            
                            if let imageData = result.value(forKey: "image") as? Data {
                                let image = UIImage(data: imageData)
                                imageView.image = image
                            }
                            
                        }
                    }
                   
                } catch {
                    
                }
                
                
            }
            
        }else{
            saveButton.isHidden = false
            saveButton.isEnabled = false
            nameTextField.text = ""
            priceTextField.text = ""
            
        }

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choseImage))
        view.addGestureRecognizer(imageGestureRecognizer)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let shopping = NSEntityDescription.insertNewObject(forEntityName: "Shopping", into: context)
        
        
        shopping.setValue(nameTextField.text, forKey: "name")
        
        if let price = Int(priceTextField.text!){
            shopping.setValue(price, forKey: "price")
        }
        
        shopping.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        shopping.setValue(data, forKey: "image")
        
        do{
            try context.save()
            print("saved")
        }catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "veriGirildi") , object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func closeKeyboard(){
        view.endEditing(true)
    }
    
    @objc func choseImage(){
      let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
}
