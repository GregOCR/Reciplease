//
//  Font.swift
//  Reciplease
//
//  Created by Greg on 11/11/2021.
//

import UIKit
import CoreLocation

enum FontFamily: String {
    case first = "Chalkduster"
    case second = "Futura Medium"
}

struct FontManager {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    static let shared = FontManager()
    
    // MARK: Internal - Methods
    
    func NS(family: FontFamily, size: Int, color: UIColor) -> [NSAttributedString.Key: NSObject] {
        return [
            .font: UIFont(
                name: family.rawValue,
                size: CGFloat(size)
            )!,
            .foregroundColor: color
        ]
    }
    
    func UI(family: FontFamily, size: Int) -> UIFont? {
        return UIFont(name: family.rawValue,
                            size: CGFloat(size))
    }
}
