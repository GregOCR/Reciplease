//
//  RecipeListTableViewCell.swift
//  Reciplease
//
//  Created by Greg on 17/11/2021.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {
    
    // MARK: - INTERFACE BUILDER
    
    // MARK: IBOutlets
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeTimerLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeIngredientsLabel: UILabel!
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureOutletsTexts()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func configure(recipe: Recipe) {
        
        if let imageUrl = URL(string: recipe.image) {
            getData(from: imageUrl) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.recipeImageView.image = UIImage(data: data)
                }
            }
        }
        
        var ingredients = ""
        
        recipe.ingredients.forEach( {
            ingredients += "\($0.food.capitalized), "
        })
        
        recipeCaloriesLabel.text = "\(Int(recipe.calories).description) cal."
        recipeTimerLabel.text = FridgeManager.shared.getFormattedTime(recipeTotalTime: recipe.totalTime)
        recipeTitleLabel.text = recipe.label
        recipeIngredientsLabel.text = String(ingredients.dropLast(2))
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let font = FontManager.shared
    
    // MARK: Private - Methods
    
    private func configureOutletsTexts() {
        recipeCaloriesLabel.font = font.UI(family: .second, size: 15)
        recipeTimerLabel.font = font.UI(family: .second, size: 15)
        recipeTitleLabel.font = font.UI(family: .second, size: 35)
        recipeIngredientsLabel.font = font.UI(family: .second, size: 17)
    }
}
