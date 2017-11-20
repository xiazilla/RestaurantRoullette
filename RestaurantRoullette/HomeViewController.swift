//
//  HomeViewController.swift
//  RestaurantRoullette
//
//  Created by Derek Chang on 10/30/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Foundation

class HomeViewController: UIViewController {

    @IBOutlet weak var logoutLabel: UIButton!
    @IBOutlet weak var settingLabel: UIBarButtonItem!
    
    let data = ["restaurants", "3.0", "5.0", "1,2,3,4", "20000"];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem();
        backItem.title = "Back";
        navigationItem.backBarButtonItem = backItem;
        
        if segue.identifier == "FeelingLucky" {
            if let toViewController = segue.destination as? SpinnerViewController {
                toViewController.data = self.data;
            }
        }
        if segue.identifier == "setting" {
            if let toViewController = segue.destination as? SettingsViewController {
                toViewController.data = self.data
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutButton(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
