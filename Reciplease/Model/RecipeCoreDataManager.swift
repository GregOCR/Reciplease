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
        let recipeEntity = RecipeEntity(context: coreDataManager.context)
        recipeEntity.label = recipe.label
        recipeEntity.ingredientLines = recipe.ingredientLines.joined(separator: ",")
        recipeEntity.totalTime = Int16(recipe.totalTime)
        recipeEntity.calories = recipe.calories
        
        coreDataManager.saveContext()
    }
    
   
    

    
    func getStoredRecipes() -> [Recipe] {
        let recipeEntities = getStoredRecipeEntities()

        
        let recipes = recipeEntities.map {
            Recipe(
                label: $0.label,
                image: "",
                source: "",
                url: "",
                ingredientLines: [],
                ingredients: [],
                calories: $0.calories,
                totalTime: Int($0.totalTime)
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
