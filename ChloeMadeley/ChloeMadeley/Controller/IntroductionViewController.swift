//
//  IntroductionViewController.swift
//  ChloeMadeley
//
//  Created by Aik Ampardjian on 19.02.16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit
import AVFoundation

class IntroductionViewController: BaseViewController {
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var avPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.selectable = true
        descriptionTextView.panGestureRecognizer.allowedTouchTypes = [NSNumber(integer: UITouchType.Indirect.rawValue)]
        descriptionTextView.attributedText = getAttributedString()
        
        let videoPath = NSBundle.mainBundle().pathForResource("intro", ofType: "mov") ?? ""
        let videoURL = NSURL(fileURLWithPath: videoPath)
        avPlayer = AVPlayer(URL: videoURL)
        
        let playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.frame = videoLayer.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.needsDisplayOnBoundsChange = true
        videoLayer.layer.addSublayer(playerLayer)
        videoLayer.layer.needsDisplayOnBoundsChange = true
        avPlayer?.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "playerItemDidReachEnd:",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: avPlayer!.currentItem)
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        avPlayer?.seekToTime(kCMTimeZero)
        avPlayer?.play()
    }
    
    private func getAttributedString() -> NSAttributedString {
        var htmlString = ""
        let htmlPath = NSBundle.mainBundle().pathForResource("Intro", ofType: "html")
        do {
            htmlString = try String(contentsOfFile: htmlPath!, encoding: NSUTF8StringEncoding)} catch _ as NSError{}
        
        do {
            let attributedString = try NSAttributedString(data: htmlString.dataUsingEncoding(NSUnicodeStringEncoding)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            return attributedString
        } catch _ as NSError {}
        
        return NSAttributedString()
    }
}