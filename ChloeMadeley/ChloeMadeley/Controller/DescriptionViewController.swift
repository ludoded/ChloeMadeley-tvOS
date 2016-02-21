//
//  DescriptionViewController.swift
//  ChloeMadeley
//
//  Created by Haik Ampardjian on 2/20/16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit

enum ChloeType {
    enum UpperBodyExercise {
        case Intro
        case MountainClimbers
        case WalkOutPushups
        case TricepDips
        case Burpees
    }
    
    enum CoreExercise {
        case Intro
        case MountainClimbers
        case Plank
        case Bicycles
        case LegPlunges
    }
    
    enum LowerBodyExercise {
        case Intro
        case SquatJumps
        case WalkingLunges
        case DonkeyKickBacks
        case Burpees
    }
    
    enum FatBurningExercise {
        case Intro
        case MountainClimbers
        case Burpees
        case SquatJumps
        case WalkingLunges
    }
    
    case UpperBody(UpperBodyExercise)
    case Core(CoreExercise)
    case LowerBody(LowerBodyExercise)
    case FatBurning(FatBurningExercise)
}

class DescriptionViewController: BaseViewController {
    @IBOutlet weak var textView: UITextView!
    
    var type: ChloeType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var htmlString = ""
        let htmlPath = NSBundle.mainBundle().pathForResource("1", ofType: "html")
        do {
            htmlString = try String(contentsOfFile: htmlPath!, encoding: NSUTF8StringEncoding)} catch _ as NSError{}
        
        do {
            let attributedString = try NSAttributedString(data: htmlString.dataUsingEncoding(NSUnicodeStringEncoding)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            textView.attributedText = attributedString
        } catch _ as NSError {}
    }
}