//
//  ListViewController.swift
//  MapsApp
//
//  Created by Mehmet Özkan on 17.09.2023.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var tableView: UITableView!
    
    var selectedName = ""
    var selectedId : UUID?
    
    var mapUserCommentArray = [MapUserModel] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        fetchDatas()
    }
    
    @objc func addButtonClicked() {
        selectedName = ""
        performSegue(withIdentifier: "toMapsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mapUserCommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = mapUserCommentArray[indexPath.row].name
        return cell
    }
    
 @objc func fetchDatas() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                mapUserCommentArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        if let id = result.value(forKey: "id") as? UUID {
                            let item = MapUserModel(id: id, name: name)
                            self.mapUserCommentArray.append(item)
                        }
                    }
                    
                  
                }
                
                tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(fetchDatas), name: NSNotification.Name("newPlaceCreated"), object: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = mapUserCommentArray[indexPath.row].name
        selectedId = mapUserCommentArray[indexPath.row].id
        performSegue(withIdentifier: "toMapsVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapsVC" {
            let destinationVC = segue.destination as! MapsViewController
            destinationVC.selectedId = selectedId
            destinationVC.selectedName = selectedName
        }
    }

}
