//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

// loadRecipesFromFavorites ?

import UIKit

class RecipeListViewController: BaseViewController {
    
    @IBOutlet weak var addSomeFavoritesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        
        if recipes.isEmpty {
            recipes = loadRecipesFromFavorites()
        }
        configureOutletsTexts()
    }
    
    @IBOutlet weak var recipeTableView: UITableView!
            
    var recipes: [Recipe] = []
    private let font = FontManager.shared

    private func loadRecipesFromFavorites() -> [Recipe] {
        return [
            
        ]
    }
    
    private func configureOutletsTexts() {
        addSomeFavoritesLabel.font = font.UI(family: .first, size: 25)
        addSomeFavoritesLabel.text = LocalizedString.addSomeFavoritesLabel
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let recipeDetailsViewController = segue.destination as? RecipeDetailsViewController,
           let recipe = sender as? Recipe
        {
            recipeDetailsViewController.recipe = recipe
        }
    }
}

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.recipeListCell, for: indexPath) as? RecipeListTableViewCell else {
            return UITableViewCell()
        }
        
        addSomeFavoritesLabel.isHidden = true
        
        let recipe = recipes[indexPath.row]
        
        cell.configure(recipe: recipe)
        
        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        performSegue(withIdentifier: SegueIdentifier.showRecipeDetailsSegue, sender: selectedRecipe)
    }
}
