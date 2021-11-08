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
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    
    @IBOutlet weak var ingredientListHeaderLabel: UILabel!
    @IBOutlet weak var clearIngredientListButton: UIButton!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    
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
    }
    
    private func configureTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    private func configureFridgeManager() {
        fridgeManager.delegate = self
    }
    
    private func configureOutletsTexts() {
        // TODO: Should set outlets texts here
        #warning("Should set outlets texts here")
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
