//
//  InstrumentationViewController.swift
//  Final Project
//
//  Created by Yash Patel on 05/01/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {

    @IBOutlet weak var rowText: UITextField!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var colText: UITextField!
    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var refreshSpeed: UISlider!
    @IBOutlet weak var refreshToggle: UISwitch!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    
    var engine : EngineProtocol = StandardEngine.getEngine()
    
    @IBAction func rowTextChanged(_ sender: UITextField) {
        let val = Int(sender.text!)
        if val != nil {
            if val! < 10 {
                updateGridSize("\(Int(engine.rows))")
            } else if val != engine.rows {
                updateGridSize(sender.text!)
            }
        } else {
            updateGridSize("\(Int(engine.rows))")
        }
    }
    
    @IBAction func colTextChanged(_ sender: UITextField) {
        let val = Int(sender.text!)
        if val != nil {
            if val! < 10 {
                updateGridSize("\(Int(engine.rows))")
            } else if val != engine.rows {
                updateGridSize(sender.text!)
            }
        } else {
            updateGridSize("\(Int(engine.rows))")
        }
    }
    
    
    @IBAction func rowTextEnd(_ sender: UITextField) {
        rowText.resignFirstResponder()
    }
    
    
    @IBAction func colTextEnd(_ sender: UITextField) {
        colText.resignFirstResponder()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        rowText.resignFirstResponder()
        colText.resignFirstResponder()
    }
    
    
    @IBAction func colStepper(_ sender: UIStepper) {
        updateGridSize("\(Int(sender.value))")
    }
    
    
    @IBAction func rowStepper(_ sender: UIStepper) {
        updateGridSize("\(Int(sender.value))")
    }
    
    
    func updateGridSize(_ value : String) {
        rowText.text = value
        colText.text = value
        
        rowStepper.value = Double(value)!
        colStepper.value = Double(value)!
        
        StandardEngine.rowsInstance = Int(value)!
        StandardEngine.colsInstance = Int(value)!
        engine = StandardEngine.getEngine()
        
        refreshToggle.isOn = false
        engine.refreshRate = 0.0
    }
    
    
    
    @IBAction func toggleRefresh(_ sender: UISwitch) {
        if sender.isOn {
            engine.refreshRate = 1/Double(refreshSpeed.value)
        } else {
            engine.refreshRate = 0.0
        }
    }
    
    
    @IBAction func changeRefreshSpeed(_ sender: UISlider) {
        if refreshToggle.isOn {
            engine.refreshRate = 0.0
            engine.refreshRate = 1/Double(refreshSpeed.value)
        } else {
            engine.refreshRate = 0.0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rowText.text = "\(Int(rowStepper.value))"
        colText.text = "\(Int(colStepper.value))"
        
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
