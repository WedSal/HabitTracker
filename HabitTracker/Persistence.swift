//
//  Persistence.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-19.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "HabitModel")
        container.loadPersistentStores{StoreDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
