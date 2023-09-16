//
//  FeedViewController.swift
//  PhotoShareApp
//
//  Created by Mehmet Özkan on 16.09.2023.
//

import UIKit
import Firebase
import SDWebImage


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    
  /*  var emailArray = [String] ()
    var commentArray = [String]()
    var imageArray = [String]() */
    
    var postArray = [Post] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        fetchFirestoreDatas()
    }
    
    func fetchFirestoreDatas () {
        let firestoreDatabase = Firestore.firestore()
        
        
        firestoreDatabase.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                
                
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                /*    self.emailArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false) */
                    
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    for doc in snapshot!.documents {
                        let documentId = doc.documentID
                        
                        if let imageUrl = doc.get("imageUrl") as? String {
                           // self.imageArray.append(imageUrl)
                            
                            if let comment = doc.get("comment") as? String {
                               // self.commentArray.append(comment)
                                
                                if let email = doc.get("email") as? String {
                                    //self.emailArray.append(email)
                                    
                                    let post = Post(email: email, comment: comment, imageUrl: imageUrl)
                                    self.postArray.append(post)
                                }
                            }
                            

                            
                        }
                        
                        

                    }
                    
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! FeedCell
        cell.emailLabel.text = postArray[indexPath.row].email
        cell.commentLabel.text = postArray[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageUrl))
        return cell
    }

  

}
