//
//  FridgeManager.swift
//  Reciplease
//
//  Created by Greg on 08/11/2021.
//

import Foundation
import UIKit

// MARK: - PROTOCOL

protocol FridgeManagerDelegate: AnyObject {
    func ingredientsDidChange()
    func ingredientsChangedEmptyValue(isEmpty: Bool)
}

class FridgeManager {
    
    // MARK: - ENUM
    
    enum Error: Swift.Error, LocalizedError {
        case failedToAddIngredientDueToAlreadyPresent
        case failedToAddIngredientDueToEmptyIngredient
        
        case failedToFetchRecipesDueToCouldNotCreateUrl
        case failedToFetchRecipesDueToInvalidResponse
        
        case failedToFetchRecipesDueToNoRecipeCorrespondingToIngredients
        
        var errorDescription: String? {
            switch self {
            case .failedToAddIngredientDueToAlreadyPresent: return LocalizedString.failedToAddIngredientDueToAlreadyPresent
            case .failedToFetchRecipesDueToCouldNotCreateUrl: return LocalizedString.failedToFetchRecipesDueToCouldNotCreateUrl
            case .failedToAddIngredientDueToEmptyIngredient: return LocalizedString.failedToAddIngredientDueToEmptyIngredient
            case .failedToFetchRecipesDueToInvalidResponse: return LocalizedString.failedToFetchRecipesDueToInvalidResponse
            case .failedToFetchRecipesDueToNoRecipeCorrespondingToIngredients: return LocalizedString.failedToFetchRecipesDueToNoRecipeCorrespondingToIngredients
            }
        }
    }
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    static let shared = FridgeManager()
    
    weak var delegate: FridgeManagerDelegate? {
        didSet {
            setup()
        }
    }
    
    /// Keeps the ingredients as lowercased String
    var ingredients: [String] = [] {
        didSet {
            delegate?.ingredientsDidChange()
            delegate?.ingredientsChangedEmptyValue(isEmpty: ingredients.isEmpty)
        }
    }
    
    // MARK: Internal - Methods
    
    func getValidatedEntries(ingredientTextFieldText : String) -> String {
        
        let referenceString = "aàbcçdeéèfghijklmnopqrstuvwxyz,'- "
        
        var validatedString = String()
        
        ingredientTextFieldText.forEach( {
            let entry = $0.lowercased().description
            if referenceString.contains(entry) {
                validatedString += entry
            }
        } )
        
        return validatedString
    }
    
    func getFormattedTime(recipeTotalTime: Int) -> String {
        let hours = recipeTotalTime/60
        let minutes = recipeTotalTime%60
        //        guard Int(hours) == 0 && Int(minutes) == 0 else { return "-- mn" }
        //        minutes = 0 ? minutes = 00 : minutes
        var result = "\(hours)h\(String(format:"%02d", minutes))"
        if hours == 0 {
            result = "\(minutes) mn"
        }
        return result
    }
    
    func getIngredientListString(ingredientLines: [String]) -> String {
        var result = String()
        ingredientLines.forEach( { result += "- \($0)\n" })
        return result
    }
    
    func fetchRecipes(completionHandler: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = createSearchRecipesUrl(ingredients: ingredients) else {
            completionHandler(.failure(.failedToFetchRecipesDueToCouldNotCreateUrl))
            return
        }
        
        networkManager.fetch(url: url) { (result: Result<RecipeSearchResponse, NetworkManager.Error>) in
            switch result {
            case .success(let recipeSearchResponse):
                let recipes = recipeSearchResponse.hits.map { $0.recipe }
                guard !recipes.isEmpty else {
                    completionHandler(.failure(.failedToFetchRecipesDueToNoRecipeCorrespondingToIngredients))
                    return
                }
                completionHandler(.success(recipes))
                return
            case .failure:
                completionHandler(.failure(.failedToFetchRecipesDueToInvalidResponse))
                return
            }
        }
    }
    
    func add(ingredientsInput: String) throws {
        
        let splittedIngredientsInput = ingredientsInput.split(separator: ",")
        var ingredientAlreadyPresent = false
        
        for ingredient in splittedIngredientsInput {
            let formattedIngredient = ingredient.trimmingCharacters(in: .whitespaces)
            if ingredients.contains(formattedIngredient) {
                ingredientAlreadyPresent = true
            } else {
                ingredients.append(formattedIngredient)
            }
        }
        if ingredientAlreadyPresent {
            throw Error.failedToAddIngredientDueToAlreadyPresent
        }
    }
    
    func clearIngredients() {
        ingredients.removeAll()
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let networkManager = NetworkManager.shared
    
    // MARK: Private - Methods
    
    private func setup() {
        ingredients = []
    }
    
    private func createSearchRecipesUrl(ingredients: [String]) -> URL? {
        let queryValue = ingredients.joined(separator: ",")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/api/recipes/v2"
        urlComponents.queryItems = [
            .init(name: "type",
                  value: "public"),
            .init(name: "app_id",
                  value: "a7499bd4"),
            .init(name: "app_key",
                  value: "d2068cb330edb02d07344821dd533820"),
            .init(name: "q",
                  value: queryValue)
        ]
        
        return urlComponents.url
    }
    
    //    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    //        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    //    }
    //
    //    func getImageView(imageUrl: String) -> UIImage {
    //        let formattedImageUrl = URL(string: imageUrl)!
    //
    //        getData(from: formattedImageUrl) { data, response, error in
    //            guard let data = data, error == nil else { return }
    //            DispatchQueue.main.async() { [weak self] in
    //                return UIImage(data: data)
    //            }
    //        }
    //    }
    
}

struct MockStruct: Decodable {
    
}
