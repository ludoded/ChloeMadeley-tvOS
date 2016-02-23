//
//  TimerViewController.swift
//  ChloeMadeley
//
//  Created by Aik Ampardjian on 22.02.16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    var audioName: String?
    var countdownStartTime: Double = 0.0
    
    var avPlayer: AVAudioPlayer?
    var countdownTimer: NSTimer?
    var countdownTimeInterval: NSTimeInterval = 300
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerHolder: UIView!
    @IBOutlet weak var replayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startOver()
        
        // Setup UI
        timerHolder.layer.borderColor = UIColor(red: 211.0 / 255.0, green: 13.0 / 255.0, blue: 135.0 / 255.0, alpha: 1.0).CGColor
        timerHolder.layer.borderWidth = 5.0
    }
    
    private func startOver() {
        if let audioName = audioName {
            let audioPath = NSBundle.mainBundle().pathForResource(audioName, ofType: "mp3")
            let audioURL = NSURL(fileURLWithPath: audioPath!)
            do {
                avPlayer = try AVAudioPlayer(contentsOfURL: audioURL)
                avPlayer?.prepareToPlay()
                avPlayer?.numberOfLoops = -1
                avPlayer?.play()
                
                countdownTimer = NSTimer(fireDate: NSDate().dateByAddingTimeInterval(countdownStartTime), interval: 1.0, target: self, selector: "countdown", userInfo: nil, repeats: true)
                NSRunLoop.currentRunLoop().addTimer(countdownTimer!, forMode: NSDefaultRunLoopMode)
                
                
            } catch _ as NSError {}
        }
    }
    
    @IBAction func replay(sender: UIButton) {
        avPlayer?.stop()
        countdownTimer?.invalidate()
        countdownTimeInterval = 300
        timerLabel.text = stringFromTimeInterval(countdownTimeInterval)
        
        startOver()
    }
    
    func countdown() {
        countdownTimeInterval--
        
        if countdownTimeInterval < 0 {
            avPlayer?.stop()
            countdownTimer?.invalidate()
        }
        else {
            timerLabel.text = stringFromTimeInterval(countdownTimeInterval)
        }
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        avPlayer?.stop()
    }
}
