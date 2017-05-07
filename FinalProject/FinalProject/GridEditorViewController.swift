//
//  GridEditorViewController.swift
//  FinalProject
//
//  Created by Yash Patel on 05/01/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController, GridViewDataSource, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    var gridTitle:String?
    var gridData:[[Int]]?
    var instrumentationVc = InstrumentationViewController()
    var engine:StandardEngine!
    let saveButton = UIBarButtonItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = StandardEngine.engine
        engine.delegate = self
        gridView.grid = self
        gridView.size = engine.rows
        
        NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "GridUpdated"),
            object: nil,
            queue: nil) { (n) in
                self.gridView.setNeedsDisplay()
        }
        
        
        loadGridData()
    }
    
    
    func loadGridData() {
        for i in 0..<self.gridView.size {
            for j in 0..<self.gridView.size { engine.grid[i, j] = CellState.empty }
        }
        for pos in gridData! {
            engine.grid[pos[0], pos[1]] = CellState.born
        }
        self.gridView.setNeedsDisplay()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = gridTitle
        
        saveButton.title = "Save"
        saveButton.action = #selector(GridEditorViewController.saveGridState)
        saveButton.target = self
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    func saveGridState() {
        if let navControl = self.navigationController {
            navControl.popViewController(animated: true)
        }
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "GridUpdated"),
            object: nil,
            userInfo: ["engine" : self]
        )
        
        self.gridData = []
        for i in 0..<self.gridView.size {
            for j in 0..<self.gridView.size {
                if engine.grid[i, j] == CellState.alive || engine.grid[i, j] == CellState.born {
                    self.gridData?.append([i,j])
                }
            }
        }
        InstrumentationViewController.gridStates[self.gridTitle!] = self.gridData
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.pattern = self.gridData!
        let file = "data"
        let text = "[{ \"saved\" : \(gridData!.description)}]"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            } catch {}
        }
    }
    
    
    func engineDidUpdate(_ withGrid: GridProtocol){
        self.gridView.setNeedsDisplay()
    }
    
    
    public subscript(row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
