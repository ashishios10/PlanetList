//
//  Persistence.swift
//  PlanetList
//
//  Created by Ashish Patel on 2024/10/11.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PlanetList")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
        
    func saveContext() throws {
        self.container.viewContext.perform {
            // Do some core data processing here
            do {
                try container.viewContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(
            concurrencyType: .privateQueueConcurrencyType
        )

        // Set the parent context
        context.parent = container.viewContext

        // If needed, ensure the background context stays
        // up to date with changes from the parent
        context.automaticallyMergesChangesFromParent = true
        return context

    }

}
