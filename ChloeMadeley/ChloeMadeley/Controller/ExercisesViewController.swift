//
//  ExercisesViewController.swift
//  ChloeMadeley
//
//  Created by Haik Ampardjian on 2/21/16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit

enum ExerciseType {
    case UpperBody
    case Core
    case LowerBody
    case Fat
}

class ExercisesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func openTimer(sender: UIButton) {
        performSegueWithIdentifier("showTimerScreen", sender: nil)
    }
    
    var selectedAttributesString: NSAttributedString?
    var selectedVideoName: String?
    
    var exerciseType: ExerciseType? = .UpperBody
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.attributedText = getAttributedString(getHTMLIntro())
        collectionView.clipsToBounds = false
    }
    
    private func getAttributedString(htmlName: String) -> NSAttributedString {
        var htmlString = ""
        let htmlPath = NSBundle.mainBundle().pathForResource(htmlName, ofType: "html")
        do {
            htmlString = try String(contentsOfFile: htmlPath!, encoding: NSUTF8StringEncoding)} catch _ as NSError{}
        
        do {
            let attributedString = try NSAttributedString(data: htmlString.dataUsingEncoding(NSUnicodeStringEncoding)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            return attributedString
        } catch _ as NSError {}
        
        return NSAttributedString()
    }
    
    private func getType(indexPath: NSIndexPath) -> ThumbsType {
        let row = indexPath.row
        
        switch exerciseType! {
        case .UpperBody:
            return row == 0 ? .MountainClimbers : row == 1 ? .WalkoutPushups : row == 2 ? .TricepDips : .Burpees
        case .Core:
            return row == 0 ? .MountainClimbers : row == 1 ? .Plank : row == 2 ? .Bicycles : .LegPlunges
        case .LowerBody:
            return row == 0 ? .SquatJumps : row == 1 ? .NPC : row == 2 ? .DonkeyKickBacks : .Burpees
        case .Fat:
            return row == 0 ? .MountainClimbers : row == 1 ? .Burpees : row == 2 ? .SquatJumps : .NPC
        }
    }
    
    private func getVideoName(type: ThumbsType) -> String {
        switch type {
        case .Bicycles: return "bicycles"
        case .Burpees: return "burpees"
        case .DonkeyKickBacks: return "donkey kick backs"
        case .LegPlunges: return "leg plunges"
        case .MountainClimbers: return "mountain climbers"
        case .NPC: return "NPC"
        case .Plank: return "plank"
        case .SquatJumps: return "squat jumps"
        case .TricepDips: return "tricep dips"
        case .WalkoutPushups: return "walkout push ups"
        }
    }
    
    private func getVideoNames() -> [String?] {
        switch exerciseType! {
        case .UpperBody:
            return [getVideoName(.MountainClimbers),getVideoName(.WalkoutPushups),getVideoName(.TricepDips),getVideoName(.Burpees)]
        case .Core:
            return [getVideoName(.MountainClimbers),getVideoName(.Plank),getVideoName(.Bicycles),getVideoName(.LegPlunges)]
        case .LowerBody:
            return [getVideoName(.SquatJumps),getVideoName(.NPC),getVideoName(.DonkeyKickBacks),getVideoName(.Burpees)]
        case .Fat:
            return [getVideoName(.MountainClimbers),getVideoName(.Burpees),getVideoName(.SquatJumps),getVideoName(.NPC)]
        }
    }
    
    private func getName(indexPath: NSIndexPath) -> String {
        let row = indexPath.row
        
        switch exerciseType! {
        case .UpperBody:
            return row == 0 ? "Mountain Climbers" : row == 1 ? "Walkout Pushups" : row == 2 ? "Tricep Dips" : "Burpees"
        case .Core:
            return row == 0 ? "Mountain Climbers" : row == 1 ? "Plank" : row == 2 ? "Bicycles" : "Leg Plunges"
        case .LowerBody:
            return row == 0 ? "Squat Jumps" : row == 1 ? "Walking Lunges" : row == 2 ? "Donkey Kick Backs" : "Burpees"
        case .Fat:
            return row == 0 ? "Mountain Climbers" : row == 1 ? "Burpees" : row == 2 ? "Squat Jumps" : "Walking Plunges"
        }
    }
    
    private func getHTML(indexPath: NSIndexPath) -> String {
        let row = indexPath.row
        
        switch exerciseType! {
        case .UpperBody:
            return row == 0 ? "UpperBodyMountainClimbers" : row == 1 ? "UpperBodyWalkoutPushUps" : row == 2 ? "UpperBodyTricepDips" : "UpperBodyBurpees"
        case .Core:
            return row == 0 ? "CoreMountainClimbers" : row == 1 ? "CorePlank" : row == 2 ? "CoreBicycles" : "CoreLegPlunges"
        case .LowerBody:
            return row == 0 ? "LowerBodySquatJumps" : row == 1 ? "LowerBodyWalkingLunges" : row == 2 ? "LowerBodyDonkeyKickBacks" : "LowerBodyBurpees"
        case .Fat:
            return row == 0 ? "FatBurningMountainClimbers" : row == 1 ? "FatBurningBurpees" : row == 2 ? "FatBurningSquatJumps" : "FatBurningWalkingLunges"
        }
    }
    
    private func getHTMLIntro() -> String {
        switch exerciseType! {
        case .UpperBody:
            return "UpperBodyIntro"
        case .Core:
            return "CoreIntro"
        case .LowerBody:
            return "LowerBodyIntro"
        case .Fat:
            return "FatBurningIntro"
        }
    }
    
    
    private func getAudioName() -> String {
        switch exerciseType! {
        case .UpperBody:
            return "upper body"
        case .Core:
            return "core"
        case .LowerBody:
            return "lower body"
        case .Fat:
            return "fat burn"
        }
    }
    
    private func getTimeInterval() -> NSTimeInterval {
        switch exerciseType! {
        case .UpperBody:
            return 13
        case .Core:
            return 12
        case .LowerBody:
            return 12
        case .Fat:
            return 14
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showExerciseViewController" {
            let vc = segue.destinationViewController as? ExerciseViewController
            vc?.attributedText = selectedAttributesString
            vc?.videoName = selectedVideoName
        }
        else if segue.identifier == "showTimerScreen" {
            let vc = segue.destinationViewController as? TimerViewController
            vc?.audioName = getAudioName()
            vc?.countdownStartTime = getTimeInterval()
            vc?.videoNames = getVideoNames()
        }
    }
}

extension ExercisesViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedVideoName = getVideoName(getType(indexPath))
        selectedAttributesString = getAttributedString(getHTML(indexPath))
        performSegueWithIdentifier("showExerciseViewController", sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    func indexPathForPreferredFocusedViewInCollectionView(collectionView: UICollectionView) -> NSIndexPath? {
        return NSIndexPath(forRow: 0, inSection: 0)
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if let indexPath = collectionView.indexPathsForSelectedItems()?.first {
            collectionView.deselectItemAtIndexPath(indexPath, animated: true)
            return false
        } else {
            return true
        }  
    }
}

extension ExercisesViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("exerciseCollectionViewCellIdentifier", forIndexPath: indexPath) as? ExerciseCollectionViewCell
        cell?.imageType = getType(indexPath)
        cell?.descriptionLabel.text = getName(indexPath)
        
        return cell!
    }
}