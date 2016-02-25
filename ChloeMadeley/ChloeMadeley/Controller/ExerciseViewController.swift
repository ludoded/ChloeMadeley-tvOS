//
//  ExerciseViewController.swift
//  ChloeMadeley
//
//  Created by Aik Ampardjian on 22.02.16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit
import AVKit

class ExerciseViewController: UIViewController {
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var attributedText: NSAttributedString?
    var videoName: String?
    var audioName: String?
    
    private var avVideoPlayer: AVPlayer?
    private var avAudioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.selectable = true
        descriptionTextView.panGestureRecognizer.allowedTouchTypes = [NSNumber(integer: UITouchType.Indirect.rawValue)]
        if let attrText = attributedText {
            descriptionTextView.attributedText = attrText
        }
        
        if let videoName = videoName {
            let videoPath = NSBundle.mainBundle().pathForResource(videoName, ofType: "mp4") ?? ""
            let videoURL = NSURL(fileURLWithPath: videoPath)
            avVideoPlayer = AVPlayer(URL: videoURL)
            
            let playerLayer = AVPlayerLayer(player: avVideoPlayer)
            playerLayer.frame = videoLayer.bounds
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
            playerLayer.needsDisplayOnBoundsChange = true
            videoLayer.layer.addSublayer(playerLayer)
            videoLayer.layer.needsDisplayOnBoundsChange = true
            avVideoPlayer?.play()
            
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "playerItemDidReachEnd:",
                name: AVPlayerItemDidPlayToEndTimeNotification,
                object: avVideoPlayer!.currentItem)
        }
        
        if let audioName = audioName {
            let audioPath = NSBundle.mainBundle().pathForResource(audioName, ofType: "mp3")
            let audioURL = NSURL(fileURLWithPath: audioPath!)
            do {
                avAudioPlayer = try AVAudioPlayer(contentsOfURL: audioURL)
                avAudioPlayer?.prepareToPlay()
                avAudioPlayer?.numberOfLoops = -1
                avAudioPlayer?.play()
            } catch _ as NSError {}
        }
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        avVideoPlayer?.seekToTime(kCMTimeZero)
        avVideoPlayer?.play()
    }
}