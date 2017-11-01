//
//  PriceThresholdViewController.swift
//  RestaurantRoullette
//
//  Created by Jamie Xia on 10/31/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit

class PriceThresholdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var data = [String] ( repeating: "", count: 5 );

    @IBOutlet weak var minField: UITextField!
    @IBOutlet weak var minPicker: UIPickerView!
    @IBOutlet weak var maxField: UITextField!
    @IBOutlet weak var maxPicker: UIPickerView!
    
    var ratings = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(data)
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
        return ratings.count;
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = ratings[row];
        return titleRow;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == minPicker) {
            self.minField.text = self.ratings[row];
        } else {
            self.maxField.text = self.ratings[row];
        }
        self.minPicker.isHidden = true;
        self.maxPicker.isHidden = true;
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder();
        if(textField == self.minField) {
            self.minPicker.isHidden = false;
        } else {
            self.maxPicker.isHidden = false;
        }
    }
    
    
    @IBAction func Next(_ sender: Any) {
        if(self.minField.text == "" || self.maxField.text == "") {
            let alert = UIAlertController(title: "Hold On!", message: "Enter a field for both min and max rating", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        } else if let x = Float(self.minField.text!), let y = Float(self.maxField.text!) {
            if(x - y > 0) {
                let alert2 = UIAlertController(title: "Uh Oh!", message: "Make sure min rating is less than max rating", preferredStyle: UIAlertControllerStyle.alert)
                alert2.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert2, animated: true, completion: nil)
            } else {
                data[1] = self.minField.text!;
                data[2] = self.maxField.text!;
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem();
        backItem.title = "Back";
        navigationItem.backBarButtonItem = backItem;
        
        if segue.identifier == "saveRatings" {
            if let toViewController = segue.destination as? MoneyViewController {
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
