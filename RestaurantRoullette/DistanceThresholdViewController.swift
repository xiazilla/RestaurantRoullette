//
//  DistanceThresholdViewController.swift
//  RestaurantRoullette
//
//  Created by Derek Chang on 10/31/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit

class DistanceThresholdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var data = [String] ( repeating: "", count: 5 );
    var distances = ["5", "10", "15", "20", "20+"]
    
    @IBOutlet weak var distanceLabel: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
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
        return distances.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = distances[row];
        return titleRow;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.distanceLabel.text = self.distances[row];
        self.dropDown.isHidden = true;
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.dropDown.isHidden = false;
    }
    
    @IBAction func next(_ sender: Any) {
        if(self.distanceLabel.text != "") {
            data[4] = self.distanceLabel.text!;
        } else {
            let alert = UIAlertController(title: "Wait!", message: "You forgot to select what distance!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem();
        backItem.title = "Back";
        navigationItem.backBarButtonItem = backItem;
        
        if segue.identifier == "saveDistance" {
            if let toViewController = segue.destination as? SpinnerViewController {
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
