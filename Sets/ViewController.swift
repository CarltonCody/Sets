//
//  ViewController.swift
//  Sets
//
//  Created by Cody Carlton on 3/4/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var setTableView: UITableView!
    
    var setTime = 60;
    var timer = Timer();
    var isTimerRunning = false;
    var isResumeTapped = false;
    
    var timer_label:String? //For updating the timerlabel
    
    var numRows = 2 //Placeholder rows
    
    var removalIndex:IndexPath? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView.delegate = self
        setTableView.dataSource = self
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:  (#selector(ViewController.upDateTimer)), userInfo: nil, repeats: true);
    }
    
    //TODO: handle pause and resume.
    
    
    @objc func upDateTimer(){
        setTime -= 1;   //Decreasing the time by 1 second.
        
        timer_label = ConversionUtils.timeString(time: TimeInterval(setTime))   //Converting the time string to a readable format.
        
        if setTime == 0 {   //When the timer reaches zero remove the cell
            moveToNextSet()
        }
        
        setTableView.reloadData() //Reloading the tableview to show changes.
    }
    
    func moveToNextSet(){
        numRows -= 1    //Decreasing the plaholder rows by one
        
        if let index = removalIndex {   //Unwrapping the index from the tableview
            setTableView.deleteRows(at: [index], with: .automatic)
        }
        
        timer.invalidate()  //Invalidating the timer so it doesn't keep running.
        setTableView.reloadData()   //Reloading the tableview
    }
    

}

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
        
        if indexPath.row == 0{  //Updating the timerlabel for only row 0.
            if let timerlabel = timer_label{    //Unwrapping the timer string.
                setCell.timerLabel.text = timerlabel
            }
        }
        
        return setCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows  //Placeholder rows for testing.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            moveToNextSet() //For manually deleting the row.
        }
    }
    
}

extension ViewController: TimerButtonDelegate{
    
    func didTapTimerButton() {
        runTimer()  //Running the timer.
    }
    
}

