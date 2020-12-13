//
//  OptionsController.swift
//  AdventureZone
//
//  Created by Joel Koehler on 12/10/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit

class OptionsController: UIViewController {

    @IBOutlet weak var distSlider: UISlider!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var unitBox: UISegmentedControl!
    
    
//    func initSlider() {
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distLabel.text = String(options.radius)
        distSlider.setValue(Float(options.radius), animated: true)
        unitLabel.text = options.unit
        if (options.unit == "mi") {
            unitBox.selectedSegmentIndex = 0
        }
        else {
            unitBox.selectedSegmentIndex = 1
        }
        
        dismissBtn.layer.cornerRadius = dismissBtn.frame.width/2
        dismissBtn.layer.masksToBounds = true
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        options.radius = Int(distSlider.value)
        if (unitBox.selectedSegmentIndex == 0) {
            options.unit = "mi"
        }
        else {
            options.unit = "km"
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func distSlider(_ sender: UISlider) {
        distLabel.text = String(Int(sender.value))
    }
    
    @IBAction func unitDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            unitLabel.text = "mi"
        case 1:
            unitLabel.text = "km"
        default:
            unitLabel.text = "mi"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
