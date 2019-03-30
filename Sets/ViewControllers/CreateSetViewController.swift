//
//  CreateSetViewController.swift
//  Sets
//
//  Created by Cody Carlton on 3/25/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import UIKit

class CreateSetViewController: UIViewController {
    
    @IBOutlet weak var setNameTextField: UITextField!
    @IBOutlet weak var minNumLabel: UILabel!
    @IBOutlet weak var secNumLabel: UILabel!
    
    var minNum: Int = 0
    var secNum: Int = 0
    var setName: String = "Set one"
    var isRest: Int = 0 //0 is a working set. 1 is a rest set.
    var dayOfWeek: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNameTextField.becomeFirstResponder()
    }
    
    @IBAction func setSelector(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            return
        case 1:
            isRest = 1
        default:
            isRest = 0
        }
    }
    
    @IBAction func incrementMinutes(_ sender: UIStepper) {
        
        minNumLabel.text = "\(Int(sender.value))"
        minNum = Int(sender.value + 60) //The 60 represents 60 seconds but displays 1 minute 2 minutes...
        
    }
    
    @IBAction func incrementSeconds(_ sender: UIStepper) {
        
        secNumLabel.text = "\(Int(sender.value))"
        secNum = Int(sender.value)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "backToMainVC", sender: self)
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        let setTime = Double(minNum + secNum)
        
        let newSet = SetModel(setTitle: setName, setTime: setTime, isRestSet: isRest, dayOfWeek: dayOfWeek!)
        
        print(newSet)
        
        performSegue(withIdentifier: "backToMainVC", sender: self)
    }
    
}//End of ViewController

extension CreateSetViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
