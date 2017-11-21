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
    @IBOutlet weak var phoneLabel: UIButton!
    var url = ""
    var number = ""
    
    var ref:DatabaseReference?
    var data = [String] ( repeating: "", count: 5 );
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers: HTTPHeaders = [
            "Authorization": "bearer HMwDUbR0-Ma6T4uq-ngh_aN1Db0TdA2Exb-alzM3_9hJyIYo9SC-96s0ccv6qDWb_ZkM2q8LMg-5iL5s6CbqK6_okog1zGuLvtc-j2rbLS1tvDBxnBQ1qLv_KljdWXYx",
            "Accept": "application/json"
        ]
        
        let radius = Int(data[4])! * 1599;
        
        Alamofire.request("https://api.yelp.com/v3/businesses/search?latitude=30.2849&longitude=-97.7341&term=\(data[0])&radius=\(radius)&price=\(data[3])&limit=50", headers: headers).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
            
            
//            struct Restaurant {
//                let id:String
//                struct Coordinates {
//                    let latitude:String
//                    let longitutde:String
//                }
//                struct Location {
//                    let display_address:String
//                }
//                let name:String
//                let phone:String
//                let price:String
//                let reviewURL:String
//                let rating:String
//            }
            
//            if let arr = jsonWithObjectRoot as? [Any] {
//                console.log(a)
//            }
//            let jsonDecoder = JSONDecoder()
//            let restaurants = try? jsonDecoder.decode(Array<Restaurant>.self, from: response.result.value as! Data)
//
//            dump(restaurants)
            
//            if let json = response.result.value {
//                if let restuarant = json["businesses"] as? NSDictionary {
//                    print(restuarant)
//                }
//            }
            
//            print(response.response?.statusCode)
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                return
            }
            
            guard let value = response.result.value as? [String: Any],
                let restaurants = value["businesses"] as? [[String: Any]] else {
                    print("Error with permissions from yelp")
                    return
            }
            
            var r:[[String: Any]] = []
            for value in restaurants {
                let low = Double(self.data[1])
                let high = Double(self.data[2])
                let currRating = value["rating"] as? Double
                if currRating! >= low! && currRating! <= high! {
                    r.append(value)
                }
            }
            
            print(r)
            
            if (r.count == 0) {
                let alert = UIAlertController(title: "Wait!", message: "No results were found, hit new search and try again!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let rand = arc4random_uniform(UInt32(r.count))
            let restaurant = r[Int(rand)]
            self.foodCategory.text = restaurant["name"] as? String
            self.title = restaurant["name"] as? String
            let blah = restaurant["location"] as? [String:Any]
            let address = blah!["address1"] as? String
            let city = blah!["city"] as? String
            let state = blah!["state"] as? String
            let phone = restaurant["display_phone"] as? String ?? "None"
            let zip = blah!["zip_code"] as? String
            let temp = "\(address ?? "") \(city ?? ""), \(state ?? "") \(zip ?? "")"
            self.phoneLabel.setTitle("\(String(describing: phone))",  for: .normal)
            let num = restaurant["phone"] as? String ?? "None"
            self.number = "\(String(describing: num))"
            self.RatingHigh.text = temp
            let rating = restaurant["rating"] as? Double ?? 0
            self.RatingLow.text = "\(rating)"
            self.PriceRange.text = restaurant["price"] as? String;
            self.url = (restaurant["url"] as? String)!;
        }

        // Do any additional setup after loading the view.
//        foodCategory.text = data[0];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openOnYelp(_ sender: Any) {
        if let url = NSURL(string: self.url){
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    @IBAction func phoneNumber(_ sender: Any) {
        if let url = NSURL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.open(url as URL)

        }
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
