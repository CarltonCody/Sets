//
//  CreateSetViewController.swift
//  Sets
//
//  Created by Cody Carlton on 3/25/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import UIKit
import CoreData

class CreateSetViewController: UIViewController {
    
    @IBOutlet weak var setNameTextField: UITextField!
    @IBOutlet weak var minNumLabel: UILabel!
    @IBOutlet weak var secNumLabel: UILabel!
    
    var minNum: Int = 0
    var secNum: Int = 0
    var setName: String = "Set one"
    var isRest: Int = 0 //0 is a working set. 1 is a rest set.
    
    var dayOfWeek: String? //This is set when navigated to this VC
    
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
            setNameTextField.text = "Rest"
        default:
            isRest = 0
        }
    }
    
    @IBAction func incrementMinutes(_ sender: UIStepper) {
        
        minNumLabel.text = "\(Int(sender.value))"
        minNum = Int(sender.value * 60) //The 60 represents 60 seconds but displays 1 minute 2 minutes...
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
        
        if setTime == 0.0 {
            showNoSetTimeErrorMsg()
            return
        }
        
        if let emptyTextField = setNameTextField.text?.isEmpty {
            
            if !emptyTextField {
                setName = setNameTextField.text!
                saveSetData(setName: setName, setTime: setTime)
                performSegue(withIdentifier: "backToMainVC", sender: self)
            }else{
                showEmptyTFErrorMsg()
                return
            }
        }
    }
    
    func saveSetData(setName: String, setTime: Double){
        
        let CDcontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //Getting the context of the CoreData object
        
        let set = Set(context: CDcontext)
        set.setTitle = setName
        set.setTime = setTime
        set.isRestSet = Int16(isRest)
        set.dayOfWeek = dayOfWeek!  //Ok to force unwrap as it is set when this VC shows.
        
        do {
            try CDcontext.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        print(set.setTitle!)
        
    }
    
    func showEmptyTFErrorMsg(){    //Showing an error if the textfield is empty
       
        let alertDialog = UIAlertController(title: "Empty Set Name", message: "Please provide a name for the set.", preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "Got it", style: .default, handler: {action in
            alertDialog.dismiss(animated: true, completion: nil)
        })
        
        alertDialog.addAction(okBtn)
        self.present(alertDialog, animated: true, completion: nil)
    }
    
    func showNoSetTimeErrorMsg(){   //Showing an error if no time duration has been set.
        
        let alertDialog = UIAlertController(title: "No Set Time", message: "No Time was added to the set. Please add the duration of the set.", preferredStyle: .alert)
        
        let okBtn = UIAlertAction(title: "Got it", style: .default, handler: {action in
            alertDialog.dismiss(animated: true, completion: nil)
        })
        
        alertDialog.addAction(okBtn)
        self.present(alertDialog, animated: true, completion: nil)
    }
    
}//End of ViewController

extension CreateSetViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
