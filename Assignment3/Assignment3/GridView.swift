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

        let gridSize = CGSize(
            width: rect.size.width / CGFloat(size),
            height: rect.size.height / CGFloat(size)
        )
        
        // Draw Grid
        (0 ... size).forEach {
            // Horizontal Lines
            drawLine(
                start: CGPoint(
                    x: rect.origin.x,
                    y: rect.origin.y + (gridSize.height * CGFloat($0))
                ),
                end: CGPoint(
                    x: rect.origin.x + rect.size.width,
                    y: rect.origin.y + (gridSize.height * CGFloat($0))
                )
            )
            
            // Vertical Lines
            drawLine(
                start: CGPoint(
                    x: rect.origin.x + (gridSize.width * CGFloat($0)),
                    y: rect.origin.y
                ),
                end: CGPoint(
                    x: rect.origin.x + (gridSize.width * CGFloat($0)),
                    y: rect.origin.y + rect.size.height
                )
            )
        }
        
    }
    
    
    func drawLine(start: CGPoint, end: CGPoint){
        let path = UIBezierPath()
        path.lineWidth = gridWidth
        path.move(to: start)
        path.addLine(to: end)
        gridColor.setStroke()
        path.stroke()
        
    }
}
