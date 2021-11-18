//
//  FridgeViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import UIKit

class FridgeViewController: UIViewController {
    
    // MARK: - Interface Builder
    
    // MARK: IBOutlets
    
    @IBOutlet weak var addToFridgeHintLabel: UILabel!
    @IBOutlet weak var ingredientListHeaderLabel: UILabel!

    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearIngredientListButton: UIButton!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    @IBOutlet weak var ingredientTextField: UITextField!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    
    // MARK: IBActions
    
    @IBAction func didTapOnAddIngredientButton() {
        guard let ingredient = ingredientTextField.text else { return }
        do {
            try fridgeManager.add(ingredient: ingredient)
        } catch {
            presentAlert(error: error)
        }
    }
    
    @IBAction func didTapOnClearIngredientListButton() {
        fridgeManager.clearIngredients()
    }
    
    @IBAction func didTapOnSearchRecipesButton() {
        fridgeManager.fetchRecipes { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.presentAlert(error: error)
                case .success:
                    print("success fetch recipes")
                }
            }
        }
    }
    
    // MARK: - INTERNAL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureFridgeManager()
        configureOutletsTexts()
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        super.prepare(for: segue, sender: sender)
    //
    //        if let recipeListViewController = segue.destination as? RecipeListViewController {
    //            recipeListViewController.recipes = ["Pizza", "Pasta"]
    //        }
    //    }
    
    //    @IBAction func didTapOnNavigateToRecipeListButton() {
    //        performSegue(withIdentifier: SegueIdentifier.showRecipeListSegue, sender: nil)
    //    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let fridgeManager = FridgeManager.shared
    
    // MARK: Private - Methods
    
    private func presentAlert(error: Error) {
        let errorMessage = (error as? LocalizedError)?.errorDescription ?? "Unknown Error"
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Reciplease"
        navigationController?.navigationBar.titleTextAttributes = FontManager.shared.NSFont(type: .secondary, size: 20, color: .white)
        navigationController?.tabBarItem.title = "Search"
    }
    
    private func configureTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    private func configureFridgeManager() {
        fridgeManager.delegate = self
    }
    
    private func configureOutletsTexts() {
        // add to fridge hint label
        addToFridgeHintLabel.font = FontManager.shared.UIFont(type: .secondary, size: 20)
        addToFridgeHintLabel.text = "What's in your fridge?"
        // add ingredient button
        addIngredientButton.titleLabel?.font = FontManager.shared.UIFont(type: .secondary, size: 20)
        addIngredientButton.setTitle("Add", for: .normal)
        // ingredients textField
        ingredientTextField.font = FontManager.shared.UIFont(type: .secondary, size: 20)
        ingredientTextField.placeholder = "lemon, cheese, sausages..."
        // ingredients listHeader label
        ingredientListHeaderLabel.font = FontManager.shared.UIFont(type: .primary, size: 20)
        ingredientListHeaderLabel.text = "Your ingredients:"
        // clear ingredients button
        clearIngredientListButton.titleLabel?.font = FontManager.shared.UIFont(type: .secondary, size: 20)
        clearIngredientListButton.setTitle("Clear", for: .normal)
        // search for recipes button
        searchRecipesButton.titleLabel?.font = FontManager.shared.UIFont(type: .secondary, size: 25)
        searchRecipesButton.titleLabel?.text = "Search for recipes"
        
    }
}

extension FridgeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fridgeManager.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.fridgeIngredientCell, for: indexPath) as? FridgeIngredientTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = fridgeManager.ingredients[indexPath.row]
        
        cell.configure(ingredient: ingredient)
        
        return cell
    }
}

extension FridgeViewController: UITableViewDelegate {
    
}

extension FridgeViewController: FridgeManagerDelegate {
    func ingredientsDidChange() {
        ingredientsTableView.reloadData()
    }
}
