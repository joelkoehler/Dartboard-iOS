//
//  ThirdViewController.swift
//  FirstApp
//
//  Created by Joel Koehler on 9/10/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ThirdViewController: UIViewController {

    var videoIsPlaying:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playVideo()
    }
    
    func playVideo() -> Void {
        if !videoIsPlaying{
            let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "rick", ofType: "mp4")!))
            
            let layer = AVPlayerLayer(player: player)
            layer.frame = view.bounds
            view.layer.addSublayer(layer)
            
            player.play()
            videoIsPlaying = true
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
