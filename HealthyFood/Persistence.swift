//
//  Persistence.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 17/1/2025.
//

import CoreData
//CoreData structure
struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    // Initializer for PersistenceController
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        
        //If you use memory storage, set the URL to
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        // Load storage and handle errors
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Successfully loaded persistent stores.")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Device(context: viewContext)
            newItem.title = "Test Device"
            newItem.content = "Device Content"
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    

}
