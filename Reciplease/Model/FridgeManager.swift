//
//  FridgeManager.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import Foundation

protocol FridgeManagerDelegate: AnyObject {
    func ingredientsDidChange()
}

class FridgeManager {
    
    enum Error: Swift.Error, LocalizedError {
        case failedToAddIngredientDueToAlreadyPresent
        case failedToAddIngredientDueToEmptyIngredient
        case failedToFetchRecipesDueToBadDecodding
        
        var errorDescription: String? {
            switch self {
            case .failedToAddIngredientDueToAlreadyPresent: return "Ingredient is already added"
            case .failedToFetchRecipesDueToBadDecodding: return "Failed to decode response"
            case .failedToAddIngredientDueToEmptyIngredient: return "Please input non-empty ingredient"
            }
        }
    }
    
    static let shared = FridgeManager()
    
    weak var delegate: FridgeManagerDelegate?
    
    var ingredients: [String] = [] {
        didSet {
            delegate?.ingredientsDidChange()
        }
    }
    
    func add(ingredient: String) throws {
        let formattedIngredient = ingredient.lowercased().trimmingCharacters(in: .whitespaces)
        
        guard !formattedIngredient.isEmpty else {
            throw Error.failedToAddIngredientDueToEmptyIngredient
        }
        
        guard !ingredients.contains(formattedIngredient) else {
            throw Error.failedToAddIngredientDueToAlreadyPresent
        }
        
        ingredients.append(formattedIngredient)
    }

    func clearIngredients() {
        ingredients.removeAll()
    }
    
    func fetchRecipes(completionHandler: (Result<MockStruct, Error>) -> Void) {
        // networkManager.fetch()
        completionHandler(.failure(.failedToFetchRecipesDueToBadDecodding))
    }
    
    
    //private let networkManager = NetworkManager.shared
}


struct MockStruct: Decodable {
    
}
