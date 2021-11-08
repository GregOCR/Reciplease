//
//  FridgeViewController.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import UIKit

class FridgeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let recipeListViewController = segue.destination as? RecipeListViewController {
            recipeListViewController.recipes = ["Pizza", "Pasta"]
        }
    }
    
    @IBAction func didTapOnNavigateToRecipeListButton() {
        performSegue(withIdentifier: SegueIdentifier.showRecipeListSegue, sender: nil)
    }
    
}
