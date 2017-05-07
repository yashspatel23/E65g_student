//
//  InstrumentationViewController.swift
//  Final Project
//
//  Created by Yash Patel on 05/01/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var rowText: UITextField!
    @IBOutlet weak var rowStepper: UIStepper!
    @IBOutlet weak var colText: UITextField!
    @IBOutlet weak var colStepper: UIStepper!
    @IBOutlet weak var refreshSpeed: UISlider!
    @IBOutlet weak var refreshToggle: UISwitch!
    
    @IBOutlet weak var tableView: UITableView!
    static var tableTitles:[String] = []
    static var gridStates:[String: [[Int]]] = [:]
    
    var finalProjectURL: String = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rowText.text = "\(Int(rowStepper.value))"
        colText.text = "\(Int(colStepper.value))"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData(finalProjectURL)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(InstrumentationViewController.addRowItem))
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    
    func addRowItem(){
        let alertController = UIAlertController(
            title: "New Pattern",
            message: "Enter pattern name:",
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(title: "Create", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                if let text = field.text {
                    if !InstrumentationViewController.tableTitles.contains(text) {
                        InstrumentationViewController.tableTitles.append(text)
                        InstrumentationViewController.gridStates[text] = []
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: [IndexPath(row: InstrumentationViewController.tableTitles.count-1, section: 0)], with: .automatic)
                        self.tableView.endUpdates()
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
    }

    
    func loadData(_ link:String) {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, resp, error) in
            guard let _:Data = data, let _:URLResponse = resp , error == nil else {
                print("error getting JSON data")
                return
            }
            self.parseJSON(data!)
        })
        task.resume()
    }
    
    
    func parseJSON(_ data: Data) {
        let json: Any?
        do { json = try JSONSerialization.jsonObject(with: data, options: []) }
        catch { return }
        
        guard let dataArray = json as? NSArray else { return }
        
        if let shapeArray = json as? NSArray {
            for i in 0 ..< dataArray.count {
                if let item = shapeArray[i] as? NSDictionary {
                    if let title = item["title"] as? String, let gridState = item["contents"] as? [[Int]] {
                        if !InstrumentationViewController.tableTitles.contains(title) {
                            InstrumentationViewController.tableTitles.append(title)
                            InstrumentationViewController.gridStates[title] = gridState
                        } else {
                            let titleExistsAlert = UIAlertController(
                                title: "Error",
                                message: "\"\(title)\" already exists",
                                preferredStyle: UIAlertControllerStyle.alert
                            )
                            titleExistsAlert.addAction(UIAlertAction(
                                title: "Dismiss",
                                style: UIAlertActionStyle.default,handler: nil
                            ))
                            self.present(titleExistsAlert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        DispatchQueue.main.async(execute: { self.reloadTableViewData() })
    }
    
    func reloadTableViewData() { self.tableView.reloadData() }
    
    
    
    
    /************************** TABLEVIEW DATASOURCE METHODS ************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InstrumentationViewController.tableTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        let label = cell.contentView.subviews.first as! UILabel
        label.text = InstrumentationViewController.tableTitles[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {}
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {}
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { return true }
    /************************** END TABLEVIEW DATASOURCE METHODS ************************/
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cancelBtn = UIBarButtonItem()
        cancelBtn.title = "Cancel"
        navigationItem.backBarButtonItem = cancelBtn
        
        let indexPath = tableView.indexPathForSelectedRow
        if let indexPath = indexPath {
            let title = InstrumentationViewController.tableTitles[indexPath.row]
            let gridState = InstrumentationViewController.gridStates[title]
            if let gevc = segue.destination as? GridEditorViewController {
                gevc.gridTitle = title
                gevc.gridData = gridState
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
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
