//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

// loadRecipesFromFavorites ?

import UIKit

class RecipeListViewController: BaseViewController {
    
    // MARK: - INTERFACE BUILDER
    
    // MARK: IBOutlets
    
    @IBOutlet weak var addSomeFavoritesLabel: UILabel!
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    var shouldDisplayFavorite = true
    
    var recipes: [Recipe] = []
    
    // MARK: Internal - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        
        configureOutletsTexts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldDisplayFavorite {
            recipes = recipeFavoriteManager.getFavoriteRecipes()
            recipeTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let recipeDetailsViewController = segue.destination as? RecipeDetailsViewController,
           let recipe = sender as? Recipe
        {
            recipeDetailsViewController.recipe = recipe
        }
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let font = FontManager.shared
    private let recipeFavoriteManager = RecipeFavoriteManager.shared
    
    // MARK: Private - Methods
    
    private func configureOutletsTexts() {
        addSomeFavoritesLabel.font = font.UI(family: .first, size: 25)
        addSomeFavoritesLabel.text = LocalizedString.addSomeFavoritesLabel
    }
    
}

extension RecipeListViewController: UITableViewDataSource {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recipesCount = recipes.count
        if recipesCount > 0 {
            addSomeFavoritesLabel.isHidden = true
        } else {
            addSomeFavoritesLabel.isHidden = false
        }
        return recipesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.recipeListCell, for: indexPath) as? RecipeListTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row]
        
        cell.configure(recipe: recipe)
        
        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        performSegue(withIdentifier: SegueIdentifier.showRecipeDetailsSegue, sender: selectedRecipe)
    }
}
