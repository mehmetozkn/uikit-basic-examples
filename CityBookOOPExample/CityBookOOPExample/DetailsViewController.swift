//
//  DetailsViewController.swift
//  CityBookOOPExample
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var selectedCity : City?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        labelCityName.text = selectedCity?.name
        imageView.image = selectedCity?.image
    }
    

    

}
