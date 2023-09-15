//
//  ViewController.swift
//  TableViewExample
//
//  Created by Mehmet Özkan on 15.09.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    
    @IBOutlet weak var tableView: UITableView!
    var cityNames = [String] ()
    var cityImages = [String]()
    var selectedName = ""
    var selectedImage = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        cityNames.append("İstanbul")
        cityNames.append("Ankara")
        
       
        cityImages.append("istanbul")
        cityImages.append("ankara")
        
     
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityNames.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = cityNames[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             cityNames.remove(at: indexPath.row)
             cityImages.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
         }

        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedName = cityNames[indexPath.row]
         selectedImage = cityImages[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.selectedImage = selectedImage
            destinationVC.selectedName = selectedName
        }
    }


}

