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
    var currentGridData:[[Int]]?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    
    @IBAction func stepButton(_ sender: Any) {
        _ = engine.step()
    }
    
    
    @IBAction func resetBtnClicked(_ sender: Any) {
        for i in 0..<engine.rows {
            for j in 0..<engine.cols {
                engine.grid[i,j] = CellState.empty
            }
        }
        self.gridView.setNeedsDisplay()
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "GridUpdated"),
            object: nil,
            userInfo: ["engine" : self]
        )
    }
    
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        currentGridData = []
        for i in 0..<engine.rows {
            for j in 0..<engine.cols {
                if engine.grid[i, j] == CellState.alive || engine.grid[i, j] ==  CellState.born  {
                    currentGridData?.append([i,j])
                }
            }
        }
        
        let alertController = UIAlertController(title: "Save Pattern", message: "Please enter pattern name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Save", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                if let text = field.text {
                    if !InstrumentationViewController.tableTitles.contains(text) {
                        InstrumentationViewController.tableTitles.append(text)
                        InstrumentationViewController.gridStates[text] = self.currentGridData
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                    } else {
                        let nameTakenAlert = UIAlertController(title: "Error", message:
                            "\"\(text)\" already exsits", preferredStyle: UIAlertControllerStyle.alert)
                        nameTakenAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                        self.present(nameTakenAlert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in textField.placeholder = "" }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.pattern = self.currentGridData!
        
        let file = "data"
        let text = "[{ \"saved\" : \(currentGridData!.description)}]"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent(file)
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            } catch {}
        }
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
