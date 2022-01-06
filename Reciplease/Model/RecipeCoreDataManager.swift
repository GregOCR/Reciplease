//
//  RecipeCoreDataManager.swift
//  Reciplease
//
//  Created by Greg on 09/12/2021.
//

import Foundation
import CoreData

class RecipeCoreDataManager {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    static let shared = RecipeCoreDataManager()
    
    // MARK: Internal - Methods
    
    func storeRecipe(recipe: Recipe) {
    
        
        let ingredientsFoodAsStringArray: [String] = recipe.ingredients.map {
            $0.food
        }
        
        let recipeEntity = RecipeEntity(context: coreDataManager.context)
        recipeEntity.label = recipe.label
        recipeEntity.image = recipe.image
        recipeEntity.url = recipe.url
        recipeEntity.uri = recipe.uri
        recipeEntity.ingredientLines = recipe.ingredientLines
        recipeEntity.ingredients = ingredientsFoodAsStringArray
        recipeEntity.calories = recipe.calories
        recipeEntity.totalTime = Double(recipe.totalTime)
        
        coreDataManager.saveContext()
    }
    
    func getStoredRecipes() -> [Recipe] {
        let recipeEntities = getStoredRecipeEntities()
        
        let recipes = recipeEntities.map { recipEntity -> Recipe in
            let recipeIngredients = recipEntity.ingredients.map {
                Ingredient(food: $0)
            }
            
            return Recipe(
                label: recipEntity.label,
                image: recipEntity.image,
                url: recipEntity.url,
                uri: recipEntity.uri,
                ingredientLines: recipEntity.ingredientLines,
                ingredients: recipeIngredients,
                calories: recipEntity.calories,
                totalTime: Int(recipEntity.totalTime)
            )
        }
        return recipes
    }
    
    func deleteStoredRecipe(recipe: Recipe) -> Bool {
        let recipeEntities = getStoredRecipeEntities()
        
        guard let recipeEntityToDelete = (recipeEntities.first {
            $0.label == recipe.label
        }) else {
            return false
        }
        
        coreDataManager.context.delete(recipeEntityToDelete)
        return true
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Methods
    
    private func getStoredRecipeEntities() -> [RecipeEntity] {
        let fetchRequest = RecipeEntity.fetchRequest()
        
        guard let recipeEntities = try? coreDataManager.context.fetch(fetchRequest) else {
            return []
        }
        
        return recipeEntities
    }
    
    private let coreDataManager = CoreDataManager.shared
}
