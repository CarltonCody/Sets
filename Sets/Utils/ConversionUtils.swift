//
//  ConversionUtils.swift
//  Sets
//
//  Created by Cody Carlton on 3/18/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import Foundation

class ConversionUtils {
    
    static func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}
