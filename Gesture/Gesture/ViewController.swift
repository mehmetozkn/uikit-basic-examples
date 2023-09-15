//
//  ViewController.swift
//  Gesture
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var ankara = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageChange))
        
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func imageChange(){
        
      
        
        if ankara == false {
            imageView.image = UIImage(named: "ankara")
            label.text = "Ankara"
            ankara = true
        }else {
            imageView.image = UIImage(named: "istanbul")
            label.text = "İstanbul"
            ankara = false
        }
       
    }
    
    

}

