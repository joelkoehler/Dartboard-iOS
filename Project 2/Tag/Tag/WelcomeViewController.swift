//
//  WelcomeViewController.swift
//  Tag
//
//  Created by Joel Koehler on 11/14/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit
import CoreData

class WelcomeViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var gamecodeTextfield: UITextField!
    @IBOutlet weak var generateCodeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameTextfield.delegate = self
        lastnameTextfield.delegate = self
        gamecodeTextfield.delegate = self
    }
    
    @IBAction func joinGameTapped(_ sender: UIButton) {
        
        var firstnameGood = false
        var lastnameGood = false
        var gamecodeGood = false
        
        guard let firstnameText = firstnameTextfield.text, !firstnameText.isEmpty else {
            return
        }
        firstnameGood = true

        guard let lastnameText = lastnameTextfield.text, !lastnameText.isEmpty else {
            return
        }
        lastnameGood = true
        
        guard let gamecodeText = gamecodeTextfield.text, !gamecodeText.isEmpty else {
            return
        }
        if (gamecodeTextfield.text!.count) == 6 {
            gamecodeGood = true
        }
        
        if (firstnameGood && lastnameGood && gamecodeGood) {
            let MOC = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

            
            let newPlayer = Player(context: MOC!)
            newPlayer.firstname = firstnameTextfield.text
            newPlayer.lastname = lastnameTextfield.text

            // TODO: check check for existing games
            // if gamecode exsists
                //add player to game
            //else make new game and add player to it
            let newGame = Game(context: MOC!)
            newGame.code = gamecodeTextfield.text
            newGame.playerCount += 1
            
            print(firstnameText + " " + lastnameText + " added to game with code " + gamecodeText)
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func generateCodeBtn(_ sender: Any) {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let code = String((0..<6).map{ _ in letters.randomElement()! })
        gamecodeTextfield.text = code
    }
    
}



