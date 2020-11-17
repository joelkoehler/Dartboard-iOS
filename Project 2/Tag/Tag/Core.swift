//
//  Core.swift
//  Tag
//
//  Created by Joel Koehler on 11/15/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import Foundation

class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
    
    func setIsNewUser() {
        UserDefaults.standard.set(false, forKey: "isNewUser")
    }
    
}
