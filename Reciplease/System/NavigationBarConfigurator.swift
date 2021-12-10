//
//  NavigationBarNavigator.swift
//  Reciplease
//
//  Created by Greg on 02/12/2021.
//

import UIKit

class NavigationBarConfigurator {
    static let shared = NavigationBarConfigurator()
    
    func setupCustomNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .darkGray
        
        appearance.titleTextAttributes = [
            .foregroundColor : UIColor.white,
            .font : FontManager.shared.UI(family: .first, size: 20)!
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor : UIColor.gray,
            .font : FontManager.shared.UI(family: .first, size: 20)!
        ]
        
        let globalAppearance = UINavigationBar.appearance()
        
        globalAppearance.tintColor = .lightGray
        
        globalAppearance.compactAppearance = appearance
        globalAppearance.scrollEdgeAppearance = appearance
        globalAppearance.standardAppearance = appearance
        globalAppearance.compactScrollEdgeAppearance = appearance
        
    }
}
