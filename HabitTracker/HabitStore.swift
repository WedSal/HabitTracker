//
//  HabitStore.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-03.
//

import Foundation
import CoreData



class HabitStore: ObservableObject {
    @Published var habits: [HabitCD] = []
    
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchHabits()
        
    }
    
    
    func fetchHabits() {
        let request: NSFetchRequest<HabitCD> = HabitCD.fetchRequest()
        do {
            habits = try context.fetch(request)
            
        } catch {
            print("Failed to fetch habits: \(error)")
        }
    }
    
    
    func addHabit(name: String, plannedDays: [Date]) {
        let newHabit = HabitCD(context: context)
        newHabit.id = UUID()
        newHabit.name = name
        newHabit.plannedDays = plannedDays as NSObject
        newHabit.completedDays = [] as NSObject
        newHabit.currentStreak = 0
        
        
        saveContext()
        fetchHabits()
        
    }
    
    
    
    func toggleHabitCompletion(habitid: UUID, on date: Date){
        if let habit = habits.first(where: {$0.id == habitid }) {
            var completedDates = habit.completedDays as? Set<Date> ?? Set<Date>()
            
            if completedDates.contains(date) {
                completedDates.remove(date)
                habit.currentStreak = max(0, habit.currentStreak - 1)
                
            } else {
                completedDates.insert(date)
                
                let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: date)!
                if completedDates.contains(previousDate) {
                    habit.currentStreak += 1
                } else {
                    habit.currentStreak = 1
                }
            }
            
            habit.completedDays = completedDates as NSObject
            saveContext()
            fetchHabits()
           
            
        }
        
        
    }
    
    
    
    func deleteHabit(_ habit: HabitCD) {
        context.delete(habit)
        saveContext()
        fetchHabits()
    }
    
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(" Failed to save context: \(error)")
        }
    }
    
    
}
