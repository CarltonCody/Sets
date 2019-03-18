//
//  CardView.swift
//  Sets
//
//  Created by Cody Carlton on 3/9/19.
//  Copyright © 2019 Cody Carlton. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CardView : UIView{
    
    @IBInspectable var cornerRadius : CGFloat = 10
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    @IBInspectable var shadowOffSetWidth : Int = 0
    @IBInspectable var shadowOffSetHeight : Int = 1
    
    @IBInspectable var shadowOpacity : Float = 0.2
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        
        layer.shadowColor = shadowColor?.cgColor
        
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        
        layer.shadowOpacity = shadowOpacity
    }
}
