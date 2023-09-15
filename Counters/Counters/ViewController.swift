//
//  ViewController.swift
//  Counters
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var timer = Timer()
    var kalanZaman = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kalanZaman = 5
        
        label.text = "Zaman: \(kalanZaman)"
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }
    
    @objc func timerFunc(){
        label.text = "Zaman: \(kalanZaman)"
        
        kalanZaman = kalanZaman - 1
        
        if kalanZaman == 0 {
            label.text = "Süre Bitti"
            timer.invalidate()
            kalanZaman = 5
        }
        
    }
    
}

