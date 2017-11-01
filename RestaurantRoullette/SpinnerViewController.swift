//
//  SpinnerViewController.swift
//  RestaurantRoullette
//
//  Created by Derek Chang on 10/31/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

    @IBOutlet weak var foodCategory: UILabel!
    @IBOutlet weak var RatingHigh: UILabel!
    @IBOutlet weak var RatingLow: UILabel!
    @IBOutlet weak var PriceRange: UILabel!
    @IBOutlet weak var Radius: UILabel!
    
    var data = [String] ( repeating: "", count: 5 );
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        foodCategory.text = data[0];
        RatingHigh.text = data[1];
        RatingLow.text = data[2];
        PriceRange.text = data[3];
        Radius.text = data[4];
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

}
