//
//  VideoView.swift
//  ChloeMadeley
//
//  Created by Aik Ampardjian on 20.02.16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit

class VideoView: UIView {
    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocusInContext(context, withAnimationCoordinator: coordinator)
        
        let oldFrame = self.frame
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
//                    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width * 1.25, oldFrame.size.height * 1.1)
//                    self.center = CGPointMake(oldFrame.origin.x + oldFrame.size.width / 2, oldFrame.origin.y + oldFrame.size.height / 2)
//                    self.layoutIfNeeded()
                },
                completion: nil)
        }
        else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
//                    self.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width / 1.25, oldFrame.size.height / 1.1)
//                    self.center = CGPointMake(oldFrame.origin.x + oldFrame.size.width / 2, oldFrame.origin.y + oldFrame.size.height / 2)
//                    self.layoutIfNeeded()
                },
                completion: nil)
        }
    }
}