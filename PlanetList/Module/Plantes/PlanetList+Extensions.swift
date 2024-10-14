//
//  PlanetList+Extensions.swift
//  PlanetList
//
//  Created by Ashish Patel on 2024/10/13.
//

import Foundation
import CoreData
import Models

extension Planet {
    
    // the color associated with a PlanetEntity is the same as that of its location's color
    
    // this whole bunch of static functions lets me do a simple fetch and
    // CRUD operations through the AppDelegate, including one called saveChanges(),
    // so that i don't have to litter a whole bunch of try? moc.save() statements
    // out in the Views.
    
    static func count() async -> Int {
        let context = PersistenceController.shared.backgroundContext()
        let response = await context.perform {
            let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
            do {
                let itemCount = try PersistenceController.shared.container.viewContext.count(for: fetchRequest)
                return itemCount
            }
            catch let error as NSError {
                print("Error counting PlanetEntities: \(error.localizedDescription), \(error.userInfo)")
                return 0
            }
        }
        return response
    }
    
    static func allPlanetEntities() async -> [PlanetEntity] {
        let context = PersistenceController.shared.backgroundContext()
        let response = await context.perform {
            let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
            fetchRequest.returnsDistinctResults = true
            do {
                let items = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
                return items
            }
            catch let error as NSError {
                print("Error getting PlanetEntities: \(error.localizedDescription), \(error.userInfo)")
                return [PlanetEntity]()
            }
        }
        return response
    }
    
    static func entityExist(name: String, created: String) async -> Bool {
        let context = PersistenceController.shared.backgroundContext()
        let response = await context.perform {
            let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name = %@ && created = %@", name, created)
            do {
                let items = try context.fetch(fetchRequest)
                return items.count > 0
            }
            catch let error as NSError {
                print("Error getting PlanetEntities: \(error.localizedDescription), \(error.userInfo)")
                return false
            }
        }
        return response
    }
    
    // addNewItem is the user-facing add of a new entity.  since these are
    // Identifiable objects, this makes sure we give the entity a unique id, then
    // hand it back so the user can fill in what's important to them.
    static func addNewItem() -> PlanetEntity {
        let context = PersistenceController.shared.container.viewContext
        let newItem = PlanetEntity(context: context)
        return newItem
    }
    
    static func saveChanges() {
        try? PersistenceController.shared.saveContext()
    }
}
