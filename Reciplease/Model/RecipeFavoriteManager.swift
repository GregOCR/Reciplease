//
//  RecipeFavoriteManager.swift
//  Reciplease
//
//  Created by Greg on 09/12/2021.
//

import Foundation

class RecipeFavoriteManager {
    
    static let shared = RecipeFavoriteManager()
    
    private var fakeStoredRecipes: [Recipe] = [] {
        didSet {
            print(fakeStoredRecipes.description)
        }
    }
    
    func addRecipeToFavorite(recipe: Recipe) -> Bool {
        guard getIndexOfRecipe(recipe) == nil else { return false }
        fakeStoredRecipes.append(recipe)
        return true
    }
    
    func deleteRecipeFromFavorite(recipe: Recipe) -> Bool {
        fakeStoredRecipes.remove(at: getIndexOfRecipe(recipe) ?? 0)
        return true
    }
    
    func getFavoriteRecipes() -> [Recipe] {
        return fakeStoredRecipes
    }
    
    private func getIndexOfRecipe(_ recipe: Recipe) -> Int? {
        let recipeLabel = recipe.label.description
        return fakeStoredRecipes.firstIndex(where: {$0.label.description == recipeLabel})
    }
}
