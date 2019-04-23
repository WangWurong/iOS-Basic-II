//
//  ViewController.swift
//  SoundShaker
//
//  Created by 大兔子殿下 on 4/22/19.
//  Copyright © 2019 大兔子殿下. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            let randomNumber = Int(arc4random_uniform(UInt32(7)) + 1)
            print(randomNumber)
            let fileLocation = Bundle.main.path(forResource: "shake" + String(randomNumber), ofType: "mp3")
            do {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
                player.play()
            } catch {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

