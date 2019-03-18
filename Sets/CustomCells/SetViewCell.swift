//
//  SetViewCell.swift
//  Sets
//
//  Created by Cody Carlton on 3/9/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import UIKit

protocol TimerButtonDelegate {
    func didTapTimerButton()
}

class SetViewCell: UITableViewCell {
    
    var delegate: TimerButtonDelegate?
    
    var paused = false
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var setTitle: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    
    @IBAction func timerButtonTapped(_ sender: Any) {
        
        if !paused{
            timerButton.setImage(UIImage(named: "round_pause_black_48pt"), for: .normal)
            paused = true
        } else if  paused{
            timerButton.setImage(UIImage(named: "round_play_arrow_black_48pt"), for: .normal)
            paused = false
        }
        
        delegate?.didTapTimerButton()
    }
    
}

