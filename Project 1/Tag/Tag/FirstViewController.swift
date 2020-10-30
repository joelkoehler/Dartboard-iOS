//
//  FirstViewController.swift
//  Tag
//
//  Created by Joel Koehler on 10/29/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func openActivityTapped(_ sender: Any) {
        let ActivityViewController = storyboard?.instantiateViewController(identifier: "ActivityViewController")
        present(ActivityViewController!, animated: true, completion: nil)
    }
    
}

