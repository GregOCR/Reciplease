//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeNumberOfLikesLabel: UILabel!
    @IBOutlet weak var recipeTimerLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var ingredientListTextView: UITextView!
    
    @IBOutlet weak var getRecipeDirectionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureOutletsTexts()

    }
    
    private let font = FontManager.shared
    
    private func configureNavigationBar() {
        navigationItem.title = "Reciplease"
        navigationController?.navigationBar.titleTextAttributes = font.NSFont(type: .primary, size: 20, color: .white)
    }
    
    private func configureOutletsTexts() {
        recipeNumberOfLikesLabel.font = font.UIFont(type: .secondary, size: 15)
        recipeTimerLabel.font = font.UIFont(type: .secondary, size: 15)
        recipeTitleLabel.font = font.UIFont(type: .secondary, size: 35)
        ingredientsLabel.font = font.UIFont(type: .primary, size: 25)
        ingredientsLabel.text = "Ingredients"
        ingredientListTextView.font = font.UIFont(type: .primary, size: 15)
        getRecipeDirectionsButton.titleLabel?.font = font.UIFont(type: .secondary, size: 25)
        getRecipeDirectionsButton.titleLabel?.text = "Get directions"
    }
}
