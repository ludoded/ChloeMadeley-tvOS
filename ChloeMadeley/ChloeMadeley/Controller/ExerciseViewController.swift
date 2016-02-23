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
    var avPlayer: AVPlayer?
    
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
            avPlayer = AVPlayer(URL: videoURL)
            
            let playerLayer = AVPlayerLayer(player: avPlayer)
            playerLayer.frame = videoLayer.bounds
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
            playerLayer.needsDisplayOnBoundsChange = true
            videoLayer.layer.addSublayer(playerLayer)
            videoLayer.layer.needsDisplayOnBoundsChange = true
            avPlayer?.play()
            
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "playerItemDidReachEnd:",
                name: AVPlayerItemDidPlayToEndTimeNotification,
                object: avPlayer!.currentItem)
        }
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        avPlayer?.seekToTime(kCMTimeZero)
        avPlayer?.play()
    }
}