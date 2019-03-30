//
//  ViewController.swift
//  Sets
//
//  Created by Cody Carlton on 3/4/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import UIKit

let toCreateSegueId: String = "goToCreateSetSegue"

class ViewController: UIViewController {

    @IBOutlet weak var setTableView: UITableView!
    @IBOutlet weak var daySegmentControl: UISegmentedControl!
    
    var setTime: Double = 60
    var timer = Timer()
    var isTimerRunning = false
    var isResumeTapped = false
    var timer_label: String? //For updating the timerlabel
    var numRows = 0 //Placeholder rows
    var removalIndex: IndexPath?
    var setArray: [SetModel]?
    var dayOfWeek: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayOfWeek = Date().dayOfWeek()
        
        if let day = dayOfWeek{
            daySegmentControl.selectedSegmentIndex = getCurrentDay(currentDay: day)
        }
        
        
        
        //Place holder data
        let setOne = SetModel(setTitle: "Set one", setTime: 90, isRestSet: 0, dayOfWeek: "Mon")
        let setTwo = SetModel(setTitle: "Rest", setTime: 60, isRestSet: 1, dayOfWeek: "Mon")
        let setThree = SetModel(setTitle: "SetTwo", setTime: 60, isRestSet: 0, dayOfWeek: "Mon")
        
        setArray = [setOne, setTwo, setThree]
        
        if let numberOfRows = setArray{
            numRows = numberOfRows.count
        }
        
        setTime = setArray![0].setTime!
        
        setTableView.delegate = self
        setTableView.dataSource = self
        
    }
    
    @IBAction func daySelected(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            dayOfWeek = "Mon"
        case 1:
            dayOfWeek = "Tue"
        case 2:
            dayOfWeek = "Wed"
        case 3:
            dayOfWeek = "Thu"
        case 4:
            dayOfWeek = "Fri"
        case 5:
            dayOfWeek = "Sat"
        case 6:
            dayOfWeek = "Sun"
        default:
            dayOfWeek = "Mon"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toCreateSegueId {
            
            let createSetVC = segue.destination as! CreateSetViewController
            createSetVC.dayOfWeek = dayOfWeek
            
        }
    }
    
    @IBAction func goToCreateSet(_ sender: Any) {
        self.performSegue(withIdentifier: toCreateSegueId, sender: nil)
    
    }
    
    @IBAction func backFromCreate(segue: UIStoryboardSegue){
        //MARK: - Reload data
    }
    
    func getCurrentDay(currentDay: String) -> Int{
        
        switch currentDay {
        case "Mon":
            return 0
        case "Tue":
            return 1
        case "Wed":
            return 2
        case "Thu":
            return 3
        case "Fri":
            return 4
        case "Sat":
            return 5
        case "Sun":
            return 6
        default:
            return 0
        }
        
    }
    
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:  (#selector(ViewController.upDateTimer)), userInfo: nil, repeats: true)
    }
    
    //TODO: handle pause and resume.
    
    
    @objc func upDateTimer(){
        setTime -= 1;   //Decreasing the time by 1 second.
        
        if setTime == 0 {   //When the timer reaches zero remove the cell
            moveToNextSet()
        }
        
        if let arrayCount = setArray {
            if arrayCount.count > 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                let timerLabel:UILabel = setTableView.cellForRow(at: indexPath)?.viewWithTag(1) as! UILabel
                
                timer_label = ConversionUtils.timeString(time: TimeInterval(setTime))   //Converting the time string to a readable format.
                
                timerLabel.text = timer_label
            }else{
                timer.invalidate()
            }
        }
    }
    
    
    func moveToNextSet(){
        numRows -= 1    //Decreasing the plaholder rows by one
        setArray?.remove(at: 0)
        timer.invalidate()  //Invalidating the timer so it doesn't keep running.
        
        if let index = removalIndex {   //Unwrapping the index from the tableview
            setTableView.deleteRows(at: [index], with: .automatic)
        }
        
        setTableView.reloadData()   //Reloading the tableview
        
        if let arrayCount = setArray {
            if arrayCount.count < 0 {
                timer.invalidate()
            }else{
                runTimer()
            }
        }
    }
    
}//End of ViewController.

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let setCell = tableView.dequeueReusableCell(withIdentifier: "setCell", for: indexPath) as! SetViewCell
        
        setCell.delegate = self
        
        removalIndex = indexPath    //Setting the indexPath to the variable to use in another function.
        
        if indexPath.row > 0 {  //Hidding the button for any rows that aren't at 0 index.
            setCell.timerButton.isHidden = true
        }else{
            setCell.timerButton.isHidden = false
        }
        
        if let set_title = setArray {
            setCell.setTitle.text = set_title[indexPath.row].setTitle
        }
        
        if let set_timer = setArray {
            setCell.timerLabel.text = ConversionUtils.timeString(time: set_timer[indexPath.row].setTime!)
        }
        
        return setCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows  //Placeholder rows for testing.
        
        //return setArray?.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            moveToNextSet() //For manually deleting the row.
        }
    }
    
}//End of Tableview delegate/datasource.

extension ViewController: TimerButtonDelegate{
    
    func didTapTimerButton() {
        runTimer()  //Running the timer.
    }
    
}//End of TimerButtonDelegate.

extension Date{
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).capitalized
    }
}

