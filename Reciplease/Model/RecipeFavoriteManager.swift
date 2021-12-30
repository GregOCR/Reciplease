//
//  RecipeFavoriteManager.swift
//  Reciplease
//
//  Created by Greg on 09/12/2021.
//

import Foundation

class RecipeFavoriteManager {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    static let shared = RecipeFavoriteManager()
        
    // MARK: Internal - Methods
    
    func isRecipeFavorited(recipe: Recipe) -> Bool {
        let favoritedStoredRecipes = recipeCoreDataManager.getStoredRecipes()
        return favoritedStoredRecipes.contains { storedRecipe in
            storedRecipe.label == recipe.label
        }
    }
    
    func toggleRecipeInFavorite(recipe: Recipe) -> Bool {
        if isRecipeFavorited(recipe: recipe) {
            return deleteRecipeFromFavorite(recipe: recipe)
        } else {
            return addRecipeToFavorite(recipe: recipe)
        }
    }
    
    func deleteRecipeFromFavorite(recipe: Recipe) -> Bool {
        recipeCoreDataManager.deleteStoredRecipe(recipe: recipe)
    }
    
    func getFavoriteRecipes() -> [Recipe] {
        return recipeCoreDataManager.getStoredRecipes()
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let recipeCoreDataManager = RecipeCoreDataManager.shared

    // MARK: Private - Methods
    
    private func addRecipeToFavorite(recipe: Recipe) -> Bool {
        guard !isRecipeFavorited(recipe: recipe) else { return false }
        recipeCoreDataManager.storeRecipe(recipe: recipe)
        return true
    }
}
