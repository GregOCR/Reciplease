//
//  RecipeSearchResponse.swift
//  Reciplease
//
//  Created by Greg on 26/11/2021.
//

import Foundation

// MARK: - RecipeSearchResponse
struct RecipeSearchResponse: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    
    enum CodingKeys: String, CodingKey {
        case recipe
    }
}

// MARK: - Recipe
struct Recipe: Codable {
    init(label: String, image: String, url: String, uri: String, ingredientLines: [String], ingredients: [Ingredient], calories: Double, totalTime: Int) {
        self.label = label
        self.image = image
        self.url = url
        self.uri = uri
        self.ingredientLines = ingredientLines
        self.ingredients = ingredients
        self.calories = calories
        self.totalTime = totalTime
    }
    
    let label: String
    let image: String
    let url: String
    let uri: String
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories: Double
    let totalTime: Int
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let food: String
}
