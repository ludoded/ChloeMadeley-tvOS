//
//  File.swift
//  ChloeMadeley
//
//  Created by Aik Ampardjian on 19.02.16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.selectable = true
        descriptionTextView.panGestureRecognizer.allowedTouchTypes = [NSNumber(integer: UITouchType.Indirect.rawValue)]
    }
}