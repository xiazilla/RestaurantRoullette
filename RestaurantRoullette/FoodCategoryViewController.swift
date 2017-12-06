//
//  FoodCategoryViewController.swift
//  RestaurantRoullette
//
//  Created by Jamie Xia on 10/30/17.
//  Copyright © 2017 cs378. All rights reserved.
//

import UIKit

class FoodCategoryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TypeOfFood: UITextField!
//    @IBOutlet weak var dropDown: UIPickerView!
    
    var data = [String] ( repeating: "", count: 5 );

    override func viewDidLoad() {
        super.viewDidLoad()
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
//        toolBar.sizeToFit()
//        
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: nil)
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: nil)
//        
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        
//        TypeOfFood.inputView = dropDown;
//        TypeOfFood.inputAccessoryView = toolBar;
        // Do any additional setup after loading the view.
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1;
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return genres.count;
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let titleRow = genres[row];
//        return titleRow;
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        self.TypeOfFood.text = self.genres[row];
//        self.dropDown.isHidden = true;
//        view.endEditing(true)
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.resignFirstResponder();
//        self.dropDown.isHidden = false;
//    }
    
    @IBAction func MoveOn(_ sender: Any) {
        if(self.TypeOfFood.text != "") {
            if (self.TypeOfFood.text == "Surprise Me! I Can't Decide.") {
                data[0] = "restaurants"
            } else {
                data[0] = self.TypeOfFood.text!;
            }
        } else {
            let alert = UIAlertController(title: "Wait!", message: "You forgot to select what type of food!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem();
        backItem.title = "Back";
        navigationItem.backBarButtonItem = backItem;
        
        if segue.identifier == "saveCategory" {
            if let toViewController = segue.destination as? PriceThresholdViewController {
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
