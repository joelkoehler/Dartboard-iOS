//
//  FirstViewController.swift
//  FirstApp
//
//  Created by Joel Koehler on 9/10/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var counter = 0
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        countIncrement()
     }
    
    @IBAction func resetButton(_ sender: Any) {
        counter = 0
        countLabel.text = String(counter)
    }
    
    func countIncrement() -> Void {
        counter += 1
        countLabel.text = String(counter)
    }

}

