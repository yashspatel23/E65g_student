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
        
        
        // Draw Circles
        (0 ..< size).forEach { i in
            (0 ..< size).forEach { j in
                
                let origin = CGPoint(
                    x: rect.origin.x + (CGFloat(i) * gridSize.width) + gridWidth,
                    y: rect.origin.y + (CGFloat(j) * gridSize.height) + gridWidth
                )
                
                let subRectSize = CGSize(
                    width: gridSize.width - (gridWidth * 2),
                    height: gridSize.height - (gridWidth * 2)
                )
                
                let subRect = CGRect(
                    origin: origin,
                    size: subRectSize
                )
                
                let path = UIBezierPath(ovalIn: subRect)
                
                switch grid[(i,j)].description() {
                    case "alive": livingColor.setFill()
                    case "empty": emptyColor.setFill()
                    case "born": bornColor.setFill()
                    case "died": diedColor.setFill()
                    default: emptyColor.setFill()
                }
                
                path.fill()
            }
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
    
    
    var lastTouchedPosition: Position?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = nil
    }
    
    
    func process(touches: Set<UITouch>) -> Position? {
        guard touches.count == 1 else { return nil }
        let pos = convert(touch: touches.first!)
        guard lastTouchedPosition?.row != pos.row
            || lastTouchedPosition?.col != pos.col
            else { return pos }
        
        grid[pos] = grid[pos].toggle(value: grid[pos])
        setNeedsDisplay()
        return pos
    }
    
    
    func convert(touch: UITouch) -> Position {
        let location = touch.location(in: self)
        let gridHeight = frame.size.height
        let row = location.x / gridHeight * CGFloat(size)
        let gridWidth = frame.size.width
        let col = location.y / gridWidth * CGFloat(size)
        let position = (row: Int(row), col: Int(col))
        return position
    }
    
}




