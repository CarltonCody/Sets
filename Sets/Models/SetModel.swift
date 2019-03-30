//
//  SetModel.swift
//  Sets
//
//  Created by Cody Carlton on 3/19/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import Foundation

class SetModel {
    
    var setTitle: String?
    var setTime: Double?
    var isRestSet: Int? //0 is a working set. 1 is a rest set.
    var dayOfWeek: String?
    
    init() {
        self.setTitle = "Placeholder set"
        self.setTime = 60
        self.isRestSet = 0
        self.dayOfWeek = "Mon"
    }
    
    convenience init(setTitle:String, setTime:Double, isRestSet:Int, dayOfWeek:String) {
        self.init()
        self.setTitle = setTitle
        self.setTime = setTime
        self.isRestSet = isRestSet
        self.dayOfWeek = dayOfWeek
    }
    
    
}
