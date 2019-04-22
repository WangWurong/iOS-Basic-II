//
//  ViewController.swift
//  BackToJay
//
//  Created by 大兔子殿下 on 1/19/19.
//  Copyright © 2019 大兔子殿下. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "sunnyday", ofType: "mp3")
    var timer = Timer()
    
    @objc func updateTimer() {
        scrubber.value = Float(player.currentTime)
    }

    @IBAction func volumeChanged(_ sender: AnyObject) {
        player.volume = volumeSlider.value
    }
    
    @IBOutlet var volumeSlider: UISlider!
    
    @IBAction func scrubberMoved(_ sender: AnyObject) {
        player.currentTime = TimeInterval(scrubber.value)
    }
    
    @IBOutlet var scrubber: UISlider!
    
    
    @IBAction func play(_ sender: AnyObject) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: AnyObject) {
        player.pause()
        timer.invalidate()
    }
    
    @IBAction func stop(_ sender: Any) {
        timer.invalidate()
        player.pause()
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            // process error
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubber.maximumValue = Float(player.duration)
        } catch {
            // process error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

