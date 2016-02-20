//
//  TransparentButton.swift
//  ChloeMadeley
//
//  Created by Aik Ampardjian on 19.02.16.
//  Copyright © 2016 Ayk. All rights reserved.
//

import UIKit

@IBDesignable
class TransparentButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
}