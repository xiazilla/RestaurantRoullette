//
//  MoneyViewController.swift
//  RestaurantRoullette
//
//  Created by Derek Chang on 10/31/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    var data = [String] ( repeating: "", count: 5 );
    var prices = ["$", "$$", "$$$", "$$$$"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return prices.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = prices[row];
        return titleRow;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.priceLabel.inputView = dropDown
        self.priceLabel.text = self.prices[row];
        self.dropDown.isHidden = true;
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.dropDown.isHidden = false;
    }
    
    @IBAction func next(_ sender: Any) {
        if(self.priceLabel.text != "") {
            data[0] = self.priceLabel.text!;
        } else {
            let alert = UIAlertController(title: "Wait!", message: "You forgot to select a price!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem();
        backItem.title = "Back";
        navigationItem.backBarButtonItem = backItem;
        
        if segue.identifier == "savePrice" {
            if let toViewController = segue.destination as? DistanceThresholdViewController {
                toViewController.data = self.data;
            }
            
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
