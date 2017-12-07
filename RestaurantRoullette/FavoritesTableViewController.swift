//
//  FavoritesTableViewController.swift
//  RestaurantRoullette
//
//  Created by Jamie Xia on 12/6/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit
import Firebase


class FavoritesTableViewController: UITableViewController {

    var ref: DatabaseReference!
    var data = [String]()
    
    @IBAction func OpenOnYelp(_ sender: Any) {
        
        
        
    }
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        self.getData()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    func getData() {
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let users = snapshot;
            if(users.hasChild(userID!)) {
                self.ref.child("users").child(userID!).child("favorites").observeSingleEvent(of: .value, with: { (snapshot) in
                    let names = snapshot.value as! NSDictionary
                    for each in names {
                        print(each)
                        self.data.append(each.key as! String)
                    }
                    //            print(self.data)
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                    }
                }) { (error) in
                    print(error.localizedDescription)
                    
                }
            } else {
                let alert = UIAlertController(title: "Hmm", message: "You don't currently have any favorites! Go add some!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.data.count)
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let alert = UIAlertController(title: "You sure?", message: "Remove \(self.data[indexPath.row]) from favorites?", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction( title : "Delete" ,
                                             style : .destructive) { action in
                                                let userID = Auth.auth().currentUser?.uid
                                                print(self.data[indexPath.row]);
                                                
                                                self.ref.child("users").child(userID!).child("favorites").child(self.data[indexPath.row]).removeValue(completionBlock: { (err, ref) in
                                                    if err != nil {
                                                        print(err)
                                                    } else {
                                                        self.data = [String]()
                                                        DispatchQueue.main.async() {
                                                            self.viewDidLoad()
                                                        }
                                                    }})

            }
            alert.addAction(alertAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func removeFav(name: String) {
        print(name)
    }
}
