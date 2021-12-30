//
//  RecipeEntity+CoreDataProperties.swift
//  Reciplease
//
//  Created by Greg on 30/12/2021.
//
//

import Foundation
import CoreData


extension RecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var calories: Double
    @NSManaged public var ingredientLines: String
    @NSManaged public var label: String
    @NSManaged public var totalTime: Int16

}

extension RecipeEntity : Identifiable {

}
