//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Yash Patel on 4/16/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    
    // MARK: - Statistic Labels
    @IBOutlet weak var aliveLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    
    var engine: StandardEngine!
    
    func updateLabels() {
        var alive = 0
        var born = 0
        var empty = 0
        var died = 0
        engine = StandardEngine.getEngine()
        
        (0 ..< engine.rows).forEach({ row in
            (0 ..< engine.cols).forEach({ col in
                switch engine.grid[row, col] {
                    case .alive:
                        alive += 1
                    case.born:
                        born += 1
                    case.empty:
                        empty += 1
                    case.died:
                        died += 1
                }
            })
        })
        
        aliveLabel.text = "Alive: \(String(alive))"
        bornLabel.text = "Born: \(String(born))"
        emptyLabel.text = "Empty: \(String(empty))"
        diedLabel.text = "Died: \(String(died))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        
        NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "GridUpdated"),
            object: nil,
            queue: nil) { (n) in
                self.updateLabels()
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
