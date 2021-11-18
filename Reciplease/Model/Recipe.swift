//
//  RecipeManager.swift
//  Reciplease
//
//  Created by Greg on 11/11/2021.
//

import UIKit

struct Recipe {
    let image: UIImage?
    let title: String
    let keywords: [String]
    let ingredients: [String]
    let numberOfLikes: Int
    let timer: Int?
    let note: String?
}
