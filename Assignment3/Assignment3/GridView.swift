//
//  GridView.swift
//  Assignment3
//
//  Created by Yash Patel on 3/27/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

    @IBInspectable var size: Int = 20 {
        didSet {
            grid = Grid(size, size)
        }
    }
    
    @IBInspectable var livingColor: UIColor = UIColor.green
    @IBInspectable var emptyColor: UIColor = UIColor.clear
    @IBInspectable var bornColor: UIColor = UIColor.cyan
    @IBInspectable var diedColor: UIColor = UIColor.black
    @IBInspectable var gridColor: UIColor = UIColor.gray
    
    @IBInspectable var gridWidth: CGFloat = CGFloat(2.0)
    
    
    var grid = Grid(20, 20)
    
    override func draw(_ rect: CGRect) {
        
    }
    

}
