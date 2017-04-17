//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Yash Patel on 4/16/17.
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
    
    var engine : EngineProtocol = StandardEngine.engine
    
    @IBAction func toggleRefresh(_ sender: UISwitch) {
    }
    
    @IBAction func changeRefreshSpeed(_ sender: UISlider) {
    }
    
    
    @IBAction func colStepper(_ sender: UIStepper) {
        updateSize(sender)
        
        refreshToggle.isOn = false
        engine.refreshRate = 0.0
    }
    
    
    @IBAction func rowStepper(_ sender: UIStepper) {
        updateSize(sender)
        
        refreshToggle.isOn = false
        engine.refreshRate = 0.0
    }
    
    func updateSize(_ sender: UIStepper) {
        rowText.text = "\(Int(sender.value))"
        colText.text = "\(Int(sender.value))"
        StandardEngine.rowsSingleton = Int(sender.value)
        StandardEngine.colsSingleton = Int(sender.value)
        engine = StandardEngine.engine
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rowText.text = "\(Int(rowStepper.value))"
        colText.text = "\(Int(colStepper.value))"
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
