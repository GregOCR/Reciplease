//
//  Extensions.swift
//  Reciplease
//
//  Created by Greg on 23/11/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    internal func titleAttributes(string: String, fontFamily: FontFamily, size: Int) {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: FontManager.shared.UI(family: fontFamily, size: size)!
        ]
        
        let NSAttributeString = NSAttributedString(
            string: string,
            attributes: attributes
        )
        
        self.setAttributedTitle(NSAttributeString, for: .normal)
    }
}

extension UIView {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods

    internal func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 15, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 15, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
