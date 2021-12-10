//
//  RecipeFavoriteManager.swift
//  Reciplease
//
//  Created by Greg on 09/12/2021.
//

import Foundation

class RecipeFavoriteManager {
    
    static let shared = RecipeFavoriteManager()
    
    
    private var fakeStoredRecipes: [Recipe] = []
    
    func addRecipeToFavorite(recipe: Recipe) -> Bool {
        fakeStoredRecipes.append(recipe)
        return true
    }
    
    func deleteRecipeFromFavorite(recipe: Recipe) -> Bool {
        fakeStoredRecipes.remove(at: 0)
        return true
    }
    
    func getFavoriteRecipes() -> [Recipe] {
        return fakeStoredRecipes
    }
}
