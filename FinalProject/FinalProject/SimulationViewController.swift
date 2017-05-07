//
//  SimulationViewController.swift
//  Final Project
//
//  Created by Yash Patel on 05/01/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, GridViewDataSource, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    
    var engine: StandardEngine!
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    
    @IBAction func stepButton(_ sender: Any) {
        _ = engine.step()
    }
    
    
    func engineDidUpdate(_ withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        engine = StandardEngine.getEngine()
        engine.delegate = self
        gridView.grid = self
        gridView.size = engine.rows
        
        NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "GridUpdated"),
            object: nil,
            queue: nil) { (n) in
                self.gridView.setNeedsDisplay()
        }
        
        NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "GridSizeUpdated"),
            object: nil,
            queue: nil) { (n) in
                self.engine = StandardEngine.engine
                self.gridView.grid = self
                self.gridView.size = self.engine.rows
                self.gridView.setNeedsDisplay()
        }
    }
    
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
