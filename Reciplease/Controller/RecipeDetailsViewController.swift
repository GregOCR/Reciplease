//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import UIKit
import SafariServices

class RecipeDetailsViewController: BaseViewController {
    
    // MARK: - INTERFACE BUILDER
    
    // MARK: IBOutlets
    
    @IBOutlet weak var addFavoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeTimerLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var ingredientListTextView: UITextView!
    
    @IBOutlet weak var getRecipeDirectionsButton: UIButton!
    
    // MARK: IBActions
    
    @IBAction func didTapAddFavoriteButton(_ sender: UIBarButtonItem) {
        guard let recipe = recipe else {
            return
        }

        guard recipeFavoriteManager.toggleRecipeInFavorite(recipe: recipe) else { return }
        updateFavoriteButtonState()
    }
    
    @IBAction func didTapGetRecipeDirectionsButton(_ sender: UIButton) {
        showSourcePage()
    }
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    var recipe: Recipe?
    
    var recipeFavoriteManager = RecipeFavoriteManager.shared
    
    // MARK: Internal - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureOutletsTexts()
        configureRecipeImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateFavoriteButtonState()
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let font = FontManager.shared
    private let fridgeManager = FridgeManager.shared
    
    // MARK: Private - Methods
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func configureRecipeImage() {
        guard let imageUrl = URL(string: recipe?.image ?? "") else { return }
                
        getData(from: imageUrl) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.recipeImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func updateFavoriteButtonState() {
        guard let recipe = recipe else {
            return
        }

        let isRecipeFavorited = recipeFavoriteManager.isRecipeFavorited(recipe: recipe)
        let image = UIImage(systemName: isRecipeFavorited ? "star.fill" : "star")
        addFavoriteButton.image = image
        
    }
    
    private func showSourcePage() {
        if let url = URL(string: recipe?.url ?? "http://www.edamam.com" ) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let safariViewController = SFSafariViewController(url: url, configuration: config)
            safariViewController.preferredBarTintColor = UIColor.black
            present(safariViewController, animated: true)
        }
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
