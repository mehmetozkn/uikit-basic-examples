//
//  SecondViewController.swift
//  LayoutProject
//
//  Created by Mehmet Özkan on 12.09.2023.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var myLbl: UILabel!
    var myPassword = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        myLbl.text = myPassword;
        // Do any additional setup after loading the view.
    }
    


}
