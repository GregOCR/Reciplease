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
        
        //recipeIngredients = recipe.ingredients
        
        let ingredientsFoodAsStringArray: [String] = recipe.ingredients.map {
            $0.food
        }
        
        let recipeEntity = RecipeEntity(context: coreDataManager.context)
        recipeEntity.label = recipe.label
        recipeEntity.image = recipe.image
        recipeEntity.url = recipe.url
        recipeEntity.uri = recipe.uri
        recipeEntity.ingredientLines = recipe.ingredientLines.joined(separator: ",")
        recipeEntity.ingredients = ingredientsFoodAsStringArray.joined(separator: ",")
        recipeEntity.calories = recipe.calories
        recipeEntity.totalTime = Double(recipe.totalTime)
        
        coreDataManager.saveContext()
    }
    
    
    
    func getStoredRecipes() -> [Recipe] {
        let recipeEntities = getStoredRecipeEntities()
        
        
        
    
        
        let recipes = recipeEntities.map { recipeEntity -> Recipe in
            let recipeIngredientsAsString: String = recipeEntity.ingredients ?? ""
            let splittedRecipeIngredientsFood: [String] = recipeIngredientsAsString.components(separatedBy: ",")
            let recipeIngredients: [Ingredient] = splittedRecipeIngredientsFood.map {
                Ingredient(food: $0)
            }

            let ingredientsLines: [String] = (recipeEntity.ingredientLines ?? "").components(separatedBy: ",")
            
            return Recipe(
                label: recipeEntity.label ?? "",
                image: recipeEntity.image ?? "",
                url: recipeEntity.url ?? "",
                uri: recipeEntity.uri ?? "",
                ingredientLines: ingredientsLines,
                ingredients: recipeIngredients,
                calories: recipeEntity.calories,
                totalTime: Int(recipeEntity.totalTime)
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
