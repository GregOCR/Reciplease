//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Greg on 28/12/2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: Internal - Methods
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RecipleaseCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

}
