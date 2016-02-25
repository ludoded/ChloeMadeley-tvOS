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
    var videoNames: [String?]?
    var countdownStartTime: Double = 0.0
    
    private var avAudioPlayer: AVAudioPlayer?
    private var avVideoPlayer: AVPlayer?
    private var countdownTimer: NSTimer?
    private var countdownTimeInterval: NSTimeInterval = 300
    private var completedCounter: Int = 0
    private var videoTimes = [300, 240, 180, 120, 60]
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerHolder: UIView!
    @IBOutlet weak var videoHolder: UIView!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var completionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startOver()
        
        // Setup UI
        timerHolder.layer.borderColor = UIColor(red: 211.0 / 255.0, green: 13.0 / 255.0, blue: 135.0 / 255.0, alpha: 1.0).CGColor
        timerHolder.layer.borderWidth = 5.0
        updateCompletedLabel()
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        avAudioPlayer?.stop()
        countdownTimer?.invalidate()
    }
    
    @IBAction func replay(sender: UIButton) {
        avAudioPlayer?.stop()
        countdownTimer?.invalidate()
        countdownTimeInterval = 300
        completedCounter = 0
        updateCompletedLabel()
        timerLabel.text = stringFromTimeInterval(countdownTimeInterval)
        avVideoPlayer?.replaceCurrentItemWithPlayerItem(nil)
        
        startOver()
    }
    
    func countdown() {
        
        if countdownTimeInterval < 0 {
            avAudioPlayer?.stop()
            countdownTimer?.invalidate()
            completedCounter++
            updateCompletedLabel()
            
            if completedCounter < 3 {
                countdownTimeInterval = 300
                startOver()
            }
        }
        else {
            timerLabel.text = stringFromTimeInterval(countdownTimeInterval)
            
            if videoTimes.contains(Int(countdownTimeInterval)) {
                playVideo(videoTimes.indexOf(Int(countdownTimeInterval)) ?? 4)
            }
        }
        
        countdownTimeInterval--
    }
    
    private func startOver() {
        if let audioName = audioName {
            let audioPath = NSBundle.mainBundle().pathForResource(audioName, ofType: "mp3")
            let audioURL = NSURL(fileURLWithPath: audioPath!)
            do {
                avAudioPlayer = try AVAudioPlayer(contentsOfURL: audioURL)
                avAudioPlayer?.prepareToPlay()
                avAudioPlayer?.numberOfLoops = -1
                avAudioPlayer?.play()
                
                countdownTimer = NSTimer(fireDate: NSDate().dateByAddingTimeInterval(countdownStartTime), interval: 1.0, target: self, selector: "countdown", userInfo: nil, repeats: true)
                NSRunLoop.currentRunLoop().addTimer(countdownTimer!, forMode: NSDefaultRunLoopMode)
            } catch _ as NSError {}
        }
    }
    
    private func playVideo(number: Int) {
        if number >= videoNames?.count ?? 0 {
            avVideoPlayer?.replaceCurrentItemWithPlayerItem(nil)
            return
        }
        
        let videoName = videoNames?[number]
        if let videoName = videoName {
            let videoPath = NSBundle.mainBundle().pathForResource(videoName, ofType: "mp4") ?? ""
            let videoURL = NSURL(fileURLWithPath: videoPath)
            let item = AVPlayerItem(URL: videoURL)
            
            if let _ = avVideoPlayer?.currentItem {
                avVideoPlayer?.replaceCurrentItemWithPlayerItem(item)
            }
            else {
                avVideoPlayer = AVPlayer(playerItem: item)
                
                let playerLayer = AVPlayerLayer(player: avVideoPlayer)
                playerLayer.frame = videoHolder.bounds
                playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
                playerLayer.needsDisplayOnBoundsChange = true
                videoHolder.layer.addSublayer(playerLayer)
                videoHolder.layer.needsDisplayOnBoundsChange = true
            }
            
            avVideoPlayer?.muted = true
            avVideoPlayer?.play()
            
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "playerItemDidReachEnd:",
                name: AVPlayerItemDidPlayToEndTimeNotification,
                object: avVideoPlayer!.currentItem)
        }
    }
    
    private func updateCompletedLabel() {
        completionLabel.text = completedCounter < 3 ? "\(completedCounter)/3 of cycles is completed." : "Congratulations! Set is over."
    }
    
    private func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        avVideoPlayer?.seekToTime(kCMTimeZero)
        avVideoPlayer?.play()
    }
}
