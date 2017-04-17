//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Yash Patel on 4/16/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, GridViewDataSource, EngineDelegate {
    
    var engine: StandardEngine!
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    @IBOutlet weak var GridView: GridView!
    
    @IBAction func stepButton(_ sender: Any) {
        if self.GridView.gridViewDataSource != nil {
            engine.grid = self.engine.step()
        }
    }
    
    func engineDidUpdate(_ withGrid: GridProtocol) {
        self.GridView.setNeedsDisplay()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = StandardEngine.getEngine()
        engine.delegate = self
        GridView.gridViewDataSource = self
        // Do any additional setup after loading the view.
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
