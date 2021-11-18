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

        if recipes.isEmpty {
            recipes = loadRecipesFromFavorites()
        }
        
        configureNavigationBar()
    }
    
    @IBAction func didTapOnNavigateToRecipeDetailsButton() {
        performSegue(withIdentifier: SegueIdentifier.showRecipeDetailsSegue, sender: nil)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Reciplease"
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.titleTextAttributes = FontManager.shared.NSFont(type: .primary, size: 20, color: .white)
        navigationController?.tabBarItem.title = "Favorite"
    }

    var recipes: [String] = []
    
    private func loadRecipesFromFavorites() -> [String] {
        return ["haricot", "potatoes"]
    }
}

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.fridgeIngredientCell, for: indexPath) as? FridgeIngredientTableViewCell else {
            return UITableViewCell()
        }
        
//        let recipe = indexPath.row
        
        return cell
    }
}


extension RecipeListViewController: UITableViewDelegate {
    
}
