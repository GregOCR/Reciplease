//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import UIKit

class RecipeListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if recipes.isEsmpty {
            recipes = loadRecipesFromFavorites()
        }
    }
    
    
    @IBAction func didTapOnNavigateToRecipeDetailsButton() {
        performSegue(withIdentifier: SegueIdentifier.showRecipeDetailsSegue, sender: nil)
    }
    
    
    
    var recipes: [String] = []
    
    private func loadRecipesFromFavorites() -> [String] {
        return ["haricot", "potatoes"]
    }

}
