//
//  RecipeEntity+CoreDataProperties.swift
//  Reciplease
//
//  Created by Greg on 04/01/2022.
//
//

import Foundation
import CoreData


extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var calories: Double
    @NSManaged public var ingredientLines: String?
    @NSManaged public var image: String?
    @NSManaged public var url: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var label: String?
    @NSManaged public var totalTime: Double
    @NSManaged public var uri: String?

}

extension RecipeEntity : Identifiable {

}
