//
//  DetailViewController.swift
//  TableViewExample
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    var selectedImage = ""
    var selectedName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myImageView.image = UIImage(named: selectedImage)
        
        myLabel.text = selectedName
    }
    

    

}
