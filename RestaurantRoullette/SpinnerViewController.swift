//
//  SpinnerViewController.swift
//  RestaurantRoullette
//
//  Created by Derek Chang on 10/31/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Alamofire

class SpinnerViewController: UIViewController {

    @IBOutlet weak var foodCategory: UILabel!
    @IBOutlet weak var RatingHigh: UILabel!
    @IBOutlet weak var RatingLow: UILabel!
    @IBOutlet weak var PriceRange: UILabel!
    @IBOutlet weak var Radius: UILabel!
    
    var ref:DatabaseReference?
    
    var data = [String] ( repeating: "", count: 5 );
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers: HTTPHeaders = [
            "Authorization": "bearer HMwDUbR0-Ma6T4uq-ngh_aN1Db0TdA2Exb-alzM3_9hJyIYo9SC-96s0ccv6qDWb_ZkM2q8LMg-5iL5s6CbqK6_okog1zGuLvtc-j2rbLS1tvDBxnBQ1qLv_KljdWXYx",
            "Accept": "application/json"
        ]
        
//        let parameters: Parameters = [
//            "latitude": 30.2849,
//            "longitude": 97.7341,
//            "term": data[0],
//            "radius": 20000,
//            "limit": 1
//        ]
        
        
        Alamofire.request("https://api.yelp.com/v3/businesses/search?latitude=30.2849&longitude=-97.7341&term=\(data[0])&radius=20000&price=\(data[3])&limit=10", headers: headers).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
            
            
            struct Restaurant {
                let id:String
                struct Coordinates {
                    let latitude:String
                    let longitutde:String
                }
                struct Location {
                    let display_address:String
                }
                let name:String
                let phone:String
                let price:String
                let reviewURL:String
                let rating:String
            }
            
            
//            let jsonDecoder = JSONDecoder()
//            let restaurants = try? jsonDecoder.decode(Array<Restaurant>.self, from: response.result.value as! Data)
//
//            dump(restaurants)
            
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
        }

        
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
