//
//  ExerciseCollectionViewCell.swift
//  ChloeMadeley
//
//  Created by Haik Ampardjian on 2/21/16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit

enum ThumbsType: String {
    case Burpees
    case MountainClimbers
    case TricepDips
    case WalkoutPushups
    case Bicycles
    case LegPlunges
    case Plank
    case NPC
    case SquatJumps
    case DonkeyKickBacks
}

class ExerciseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbsImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imageType: ThumbsType? {
        didSet {
            thumbsImageView.image = UIImage(named: imageType?.rawValue ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbsImageView.adjustsImageWhenAncestorFocused = true
    }
}