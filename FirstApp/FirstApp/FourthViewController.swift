//
//  FourthViewController.swift
//  FirstApp
//
//  Created by Joel Koehler on 9/11/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    
    @IBOutlet weak var factLabel: UILabel!
    
    @IBOutlet weak var genButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func genButton(_ sender: Any) {
        factLabel.text = genFact()
    }
    
    func genFact() -> String {
        return "Joel Wins"
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
