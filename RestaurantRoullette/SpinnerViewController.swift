//
//  SpinnerViewController.swift
//  RestaurantRoullette
//
//  Created by Derek Chang on 10/31/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
import Alamofire
import MapKit
import Cosmos

class SpinnerViewController: UIViewController {
    
    @IBOutlet weak var foodCategory: UILabel!
    @IBOutlet weak var RatingHigh: UILabel!
    @IBOutlet weak var PriceRange: UILabel!
    @IBOutlet weak var phoneLabel: UIButton!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var RatingCosmos: CosmosView!
    @IBOutlet weak var image: UIImageView!
    
    let userID = Auth.auth().currentUser?.uid
    
    var url = ""
    var number = ""
    var RatingLow = 0.0
    var ref:DatabaseReference?
    var name = ""
    
    var data = [String] ( repeating: "", count: 5 );
    
    var longitude = 0.0
    var latitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.title = "y o u ' r e   w e l c o m e !"
        
        let headers: HTTPHeaders = [
            "Authorization": "bearer HMwDUbR0-Ma6T4uq-ngh_aN1Db0TdA2Exb-alzM3_9hJyIYo9SC-96s0ccv6qDWb_ZkM2q8LMg-5iL5s6CbqK6_okog1zGuLvtc-j2rbLS1tvDBxnBQ1qLv_KljdWXYx",
            "Accept": "application/json"
        ]
        
        let radius = Int(data[4])! * 1599;
        
        Alamofire.request("https://api.yelp.com/v3/businesses/search?latitude=30.2849&longitude=-97.7341&term=\(data[0])&radius=\(radius)&price=\(data[3])&limit=50&open_now=true", headers: headers).responseJSON { response in
            
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
            
            if (r.count == 0) {
                let alert = UIAlertController(title: "Wait!", message: "No results were found, hit new search and try again!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let rand = arc4random_uniform(UInt32(r.count))
            let restaurant = r[Int(rand)]
            print(restaurant)
            self.foodCategory.text = restaurant["name"] as? String
            let location = restaurant["location"] as? [String:Any]
            let address = location!["address1"] as? String
            let city = location!["city"] as? String
            let state = location!["state"] as? String
            let phone = restaurant["display_phone"] as? String ?? "None"
            let zip = location!["zip_code"] as? String
            let temp = "\(address ?? "") \(city ?? ""), \(state ?? "") \(zip ?? "")"
            self.phoneLabel.setTitle("\(String(describing: phone))",  for: .normal)
            let num = restaurant["phone"] as? String ?? "None"
            self.number = "\(String(describing: num))"
            self.RatingHigh.text = temp
            let rating = restaurant["rating"] as? Double ?? 0
            let image_url = restaurant["image_url"] as? String ?? ""
            let url = URL(string:image_url)
            let data = try? Data(contentsOf: url!)
            let img: UIImage = UIImage(data: data!)!
            self.image.image = img
            
            
            print(image_url)
            self.RatingCosmos.rating = rating
            self.PriceRange.text = restaurant["price"] as? String;
            self.url = (restaurant["url"] as? String)!;
            
            // grab coordinates
            let coordinates = restaurant["coordinates"] as? [String:Any]
            let latitude = coordinates!["latitude"] as? Double ?? 0.0
            let longitude = coordinates!["longitude"] as? Double ?? 0.0
            
            // use coordinates in map
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1);
            let loc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(loc, span)
            self.map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = loc
            annotation.title = restaurant["name"] as? String
            self.name = (restaurant["name"] as? String)!
            self.map.addAnnotation(annotation)
            
        }
        
        
        
        // Do any additional setup after loading the view.
        //        foodCategory.text = data[0];
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem();
        backItem.title = "Back";
        navigationItem.backBarButtonItem = backItem;
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
    @IBAction func AddToFavorites(_ sender: Any) {
        
        let uid = self.userID;
        self.ref?.child("users").child(uid!).child("favorites").childByAutoId().setValue(self.name)
        
    }
    
    @IBAction func Refresh(_ sender: Any) {
        
        self.viewDidLoad()
    }
}

