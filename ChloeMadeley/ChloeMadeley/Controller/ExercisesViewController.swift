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
    
    var exerciseType: ExerciseType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            return row == 0 ? "FatBurningMountainClimbers" : row == 1 ? "FatBurningBurpees" : row == 2 ? "FatBurningSquatJumps" : "FatBurningWalkingPlunges"
        }
    }
}

extension ExercisesViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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