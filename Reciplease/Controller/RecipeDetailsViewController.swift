//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import UIKit

class RecipeDetailsViewController: BaseViewController {
    
    var recipe: Recipe?
    
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeTimerLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var ingredientListTextView: UITextView!
    
    @IBOutlet weak var getRecipeDirectionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOutletsTexts()
        
        let imageUrl = URL(string: recipe?.image ?? "")!
                
        getData(from: imageUrl) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.recipeImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func didTapAddFavoriteButton(_ sender: UIButton) {
        
    }
    
    private let font = FontManager.shared
    private let fridgeManager = FridgeManager.shared
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func configureOutletsTexts() {
        recipeCaloriesLabel.font = font.UI(family: .second, size: 15)
        recipeCaloriesLabel.text = "\(Int(recipe?.calories ?? 0).description) cal."

        recipeTimerLabel.font = font.UI(family: .second, size: 15)
        recipeTimerLabel.text = fridgeManager.getFormattedTime(recipeTotalTime: recipe?.totalTime ?? 0)

        recipeTitleLabel.font = font.UI(family: .second, size: 35)
        recipeTitleLabel.text = recipe?.label
        
        ingredientsLabel.font = font.UI(family: .first, size: 25)
        ingredientsLabel.text = LocalizedString.ingredientLabel
        
        ingredientListTextView.font = font.UI(family: .first, size: 15)
        ingredientListTextView.text = fridgeManager.getIngredientListString(ingredientLines: recipe?.ingredientLines ?? [])
        
        getRecipeDirectionsButton.titleAttributes(string: LocalizedString.directionsButtonLabel, fontFamily: .second, size: 25)
        }
}
