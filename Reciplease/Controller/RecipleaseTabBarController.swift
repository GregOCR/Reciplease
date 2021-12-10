//
//  RecipleaseTabBarController.swift
//  Reciplease
//
//  Created by Greg on 18/11/2021.
//

import UIKit

class RecipleaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTabBarItems()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupTabBarItems() {
        guard let tabBarItems = tabBar.items else { return }
        for (index, item) in tabBarItems.enumerated() where tabBarItemModels.indices.contains(index) {
            let itemModel = tabBarItemModels[index]
            item.title = itemModel.title
            item.image = UIImage(systemName: itemModel.iconImageName)
            item.selectedImage = UIImage(systemName: itemModel.selectedIconImageName)
        }
    }
    
    private let tabBarItemModels: [TabBarItemModel] = [
        .init(
            title: LocalizedString.tabBarItemTitleSearch,
            iconImageName: ImageResource.System.magnifyingGlassCircle,
            selectedIconImageName: ImageResource.System.magnifyingGlass
        ),
        .init(
            title: LocalizedString.tabBarItemTitleFavorites,
            iconImageName: ImageResource.System.starCircle,
            selectedIconImageName: ImageResource.System.starFill
        )
    ]
}

