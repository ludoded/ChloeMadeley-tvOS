//
//  ViewController.swift
//  ChloeMadeley
//
//  Created by Aik Ampardjian on 15.02.16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var upperBodyButton: TransparentButton!
    @IBOutlet weak var coreButton: TransparentButton!
    @IBOutlet weak var lowerBodyButton: TransparentButton!
    @IBOutlet weak var fatBurningButton: TransparentButton!
    
    var exerciseType: ExerciseType = .UpperBody

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func openDescription(sender: TransparentButton) {
        if sender == upperBodyButton {
            exerciseType = .UpperBody
        }
        else if sender == coreButton {
            exerciseType = .Core
        }
        else if sender == lowerBodyButton {
            exerciseType = .LowerBody
        }
        else {
            exerciseType = .Fat
        }
        
        performSegueWithIdentifier("showExercisesViewController", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showExercisesViewController" {
            let vc = segue.destinationViewController as? ExercisesViewController
            vc?.exerciseType = exerciseType
        }
    }
}