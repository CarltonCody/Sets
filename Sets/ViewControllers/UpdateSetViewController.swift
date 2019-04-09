//
//  UpdateSetViewController.swift
//  Sets
//
//  Created by Cody Carlton on 4/4/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import UIKit
import CoreData

protocol UpdateSetDataDelegate {
    func updateSet(setID:Int, setTitle:String, setTime:Double, isRestSet:Int, dayOfWeek:String)
}

class UpdateSetViewController: UIViewController {
    
    @IBOutlet weak var set_restSegment: UISegmentedControl!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var setName: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesStepper: UIStepper!
    @IBOutlet weak var secondsStepper: UIStepper!
    
    var setID:Int = 0
    var setTitle:String = ""
    var setTime:Double = 0
    var isRestSet:Int = 0
    var dayOfWeek:String = ""
    
    var currentMinutes:Int = 0
    var currentSeconds:Int = 0
    
    var changedMinutes:Double = 0
    var changedSeconds:Double = 0
    
     var delegate: UpdateSetDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set_restSegment.selectedSegmentIndex = isRestSet
        
        setName.text = setTitle
        
        if isRestSet == 1 {
            changeBtn.isHidden = true
        }
        
        convertTimeDown(setTime: setTime)
        
    }
    
    func convertTimeDown(setTime:Double?){  //Converting the time to change the minutes and seconds separately.
        
        if let currentSetTime = setTime{
            currentMinutes = Int(currentSetTime) / 60 % 60
            currentSeconds = Int(currentSetTime) % 60
        }
        
        //Setting the current time values of the steppers.
        minutesStepper.value = Double(currentMinutes)
        secondsStepper.value = Double(currentSeconds)
        
        //Setting the default values incase the user uses one stepper but not the other.
        changedMinutes = Double(currentMinutes * 60)
        changedSeconds = Double(currentSeconds)
        
        //Displaying the current minutes and seconds.
        minutesLabel.text = "\(currentMinutes)"
        secondsLabel.text = "\(currentSeconds)"
        
    }
    
    @IBAction func changeSet_Rest(_ sender: UISegmentedControl) {
        
        isRestSet = sender.selectedSegmentIndex
        
        //Hiding the change set name button depending on whether set or rest is selected.
        if isRestSet == 0 {
            if changeBtn.isHidden == true{
                changeBtn.isHidden = false
            }
        }else{
            setName.text = "Rest"
            self.setTitle = "Rest"
            changeBtn.isHidden = true
        }
        
    }
    
    @IBAction func changeSetName(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Change set name", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Change", style: UIAlertAction.Style.default, handler: { alert -> Void in
        
            let alertTextField = alertController.textFields![0] as UITextField
            
            if let set_name = alertTextField.text{
                self.setTitle = set_name
                self.setName.text = set_name
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter new set name"
        }
       
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func incrementMinutes(_ sender: UIStepper) {
        changedMinutes = sender.value
        changedMinutes *= 60
        minutesLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func incrementSeconds(_ sender: UIStepper) {
        changedSeconds = sender.value
        secondsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func updateSet(_ sender: UIButton) {

        setTime = changedMinutes + changedSeconds
       //Sending the updated values to the mainVC to update the core data item.
        delegate?.updateSet(setID: self.setID, setTitle: self.setTitle, setTime: self.setTime, isRestSet: self.isRestSet, dayOfWeek: self.dayOfWeek)
        
        navigationController?.popViewController(animated: true)
    }
    
}
