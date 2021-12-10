//
//  StringKeys.swift
//  Reciplease
//
//  Created by Greg on 18/11/2021.
//

import Foundation

struct LocalizedString {
    // errors
    static let unknownError = "unknownError";
    static let failedToAddIngredientDueToAlreadyPresent = "failed_to_add_ingredient_due_to_already_present".localized
    static let failedToFetchRecipesDueToCouldNotCreateUrl = "failed_to_fetch_recipes_due_to_could_not_create_url".localized
    static let failedToAddIngredientDueToEmptyIngredient = "failed_to_add_ingredient_due_to_empty_ingredient".localized
    static let failedToFetchRecipesDueToInvalidResponse = "failed_to_fetch_recipes_due_to_invalid_response".localized
    static let failedToFetchRecipesDueToNoRecipeCorrespondingToIngredients = "failed_to_fetch_recipes_due_to_no_recipe_corresponding_to_ingredients".localized
    // general
    static let appTitle = "app_title".localized
    static let backButtonTitle = "app_back_button_title".localized
    static let tabBarItemTitleSearch = "tab_bar_item_title_search".localized
    static let tabBarItemTitleFavorites = "tab_bar_item_title_favorites".localized
    // FridgeViewController
    static let addToFridgeHintLabel = "add_to_fridge_hint_label".localized
    static let ingredientTextFieldPlaceholder = "ingredient_text_field_placeholder".localized
    static let ingredientListHeaderLabel = "ingredient_list_header_label".localized
    static let searchRecipesButtonTitle = "search_recipes_button_title".localized
    // RecipeDetailsViewController
    static let ingredientLabel = "ingredient_label".localized
    static let directionsButtonLabel = "directions_button_label".localized
    static let addSomeFavoritesLabel = "add_some_favorites_label".localized
}
