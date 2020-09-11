//
//  SecondViewController.swift
//  FirstApp
//
//  Created by Joel Koehler on 9/10/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var myTimer:Timer = Timer()
    var currTime = 0
    var isCounting:Bool = false
    var resetFlag:Bool = false

    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

    }
    
    @IBAction func startButton(_ sender: Any) {
        if !isCounting {
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
            isCounting = true
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        myTimer.invalidate()
        isCounting = false
    }

    @IBAction func resetButton(_ sender: Any) {
        countLabel.text = String(0)
        resetFlag = true
    }
    
    @objc func count() -> Void {
        if resetFlag {
            currTime = 0
            resetFlag = false
        }
        currTime += 1
        countLabel.text = String(currTime)
    }
    
}

