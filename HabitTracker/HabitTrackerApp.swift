//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-03.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
}
