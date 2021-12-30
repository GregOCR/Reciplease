//
//  FridgeViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

// pkoi UITableViewDelegate ?

import UIKit

class FridgeViewController: BaseViewController {
    
    // MARK: - INTERFACE BUILDER
    
    // MARK: IBOutlets
    
    @IBOutlet weak var searchTextFieldView: UIView!
    @IBOutlet weak var ingredientHeaderAndTrashButtonView: UIView!
    
    @IBOutlet weak var addToFridgeHintLabel: UILabel!
    @IBOutlet weak var ingredientListHeaderLabel: UILabel!
    
    @IBOutlet weak var searchRecipeActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    
    @IBOutlet weak var ingredientTextField: UITextField!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    // MARK: IBActions
    
    @IBAction func didTapOnAddIngredientButton() {
        
        guard ingredientTextField.text != "" else {
            searchTextFieldView.shake()
            return
        }
        let validatedEntries = fridgeManager.getValidatedEntries(ingredientTextFieldText: ingredientTextField.text ?? "")
        
        do {
            try fridgeManager.add(ingredientsInput: validatedEntries)
        } catch {
            presentAlert(error: error)
        }
        
        clearIngredientTextField()
    }
    
    
    @IBAction func didTapOnClearIngredientListButton() {
        fridgeManager.clearIngredients()
        searchRecipeButton(available: true)
    }
    
    @IBAction func didTapOnSearchRecipesButton() {
        searchRecipeButton(available: false)
        fridgeManager.fetchRecipes { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.presentAlert(error: error)
                case .success(let recipes):
                    self?.performSegue(
                        withIdentifier: SegueIdentifier.showRecipeListSegue,
                        sender: recipes
                    )
                }
                self?.searchRecipeButton(available: true)
            }
        }
    }
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTableView()
        configureFridgeManager()
        configureOutletsTexts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let recipeListViewController = segue.destination as? RecipeListViewController,
           let recipes = sender as? [Recipe]
        {
            recipeListViewController.recipes = recipes
            recipeListViewController.shouldDisplayFavorite = false
        }
    }
    
    func clearIngredientTextField() {
        ingredientTextField.text = ""
    }
    
    func searchRecipeButton(available: Bool) {
        searchRecipesButton.isEnabled = available
        searchRecipeActivityIndicatorView.isHidden = available
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let fridgeManager = FridgeManager.shared
    private let font = FontManager.shared
    
    // MARK: Private - Methods
    
    private func presentAlert(error: Error) {
        let errorMessage = (error as? LocalizedError)?.errorDescription ?? LocalizedString.unknownError
        let alertController = UIAlertController(title: "👨‍🍳", message: errorMessage, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAlertAction)
        present(alertController, animated: true, completion: nil)
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
        addToFridgeHintLabel.font = font.UI(family: .second,
                                            size: 25)
        addToFridgeHintLabel.text = LocalizedString.addToFridgeHintLabel
        // ingredients textField
        ingredientTextField.font = font.UI(family: .second,
                                           size: 20)
        ingredientTextField.placeholder = LocalizedString.ingredientTextFieldPlaceholder
        // ingredients listHeader label
        ingredientListHeaderLabel.font = font.UI(family: .first,
                                                 size: 20)
        ingredientListHeaderLabel.text = LocalizedString.ingredientListHeaderLabel
        // buttons attributes
        searchRecipesButton.titleAttributes(string: LocalizedString.searchRecipesButtonTitle,
                                            fontFamily: .second,
                                            size: 25)
    }
}

// MARK: - EXTENSIONS

extension FridgeViewController: UITableViewDataSource {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
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
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    func ingredientsChangedEmptyValue(isEmpty: Bool) {
        [searchRecipesButton,
         ingredientHeaderAndTrashButtonView,
         ingredientsTableView
        ].forEach {
            $0?.alpha = isEmpty ? 0 : 1
        }
    }
    
    func ingredientsDidChange() {
        ingredientsTableView.reloadData()
    }
}
