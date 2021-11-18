//
//  Font.swift
//  Reciplease
//
//  Created by Greg on 11/11/2021.
//

import UIKit

enum FontType: String {
    case primary = "Chalkduster"
    case secondary = "Futura Medium"
}

struct FontManager {
    
    static let shared = FontManager()
    
    func NSFont(type: FontType, size: Int, color: UIColor) -> [NSAttributedString.Key: NSObject] {
        return [NSAttributedString.Key.font:
                    UIKit.UIFont(name: type.rawValue,
                                 size: CGFloat(size))!,
                .foregroundColor: color]
    }
    
    func UIFont(type: FontType, size: Int) -> UIFont? {
        return UIKit.UIFont(name: type.rawValue,
                            size: CGFloat(size))
    }
}
