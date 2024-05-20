//
//  ContentView.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-03.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment (\.managedObjectContext) private var context
    @FetchRequest(
        entity: HabitCD.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \HabitCD.name, ascending: true)]
    ) var habits: FetchedResults<HabitCD>
    
    
    @State var showingAddHabit = false
    @StateObject var habitStore: HabitStore
    @State private var showingDeleteAlert = false
    @State private var habitToDelete: HabitCD?
    
    init() {
        let context = PersistenceController.shared.container.viewContext
                _habitStore = StateObject(wrappedValue: HabitStore(context: context))   
    }
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                LazyVStack {
                    
                    ForEach(habits, id: \.self) { habit in
                        HabitView(habit: habit, toggleHabit: { habitid, date in
                            habitStore.toggleHabitCompletion(habitid: habitid, on: date)
                        } , deleteHabit: {
                            habitToDelete = habit
                            showingDeleteAlert = true
                        }   )
                        .padding()
                        .background(Color.purple.opacity(0.3))
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .shadow(radius: 3)
                    }
                }
            }
            
            .navigationTitle("Habits")
            .toolbar {
                Button("Add Habit") {
                    showingAddHabit = true
                    
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(habitStore: habitStore)
            }
            .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete Habit"),
                message: Text("Are you sure you want to delete this habit?"),
                primaryButton: .destructive(Text("Delete")) {
                    
                    if let habit = habitToDelete {
                        habitStore.deleteHabit(habit)
                        habitToDelete = nil
                    }
                },
                secondaryButton: .cancel()
                )
            }
            .background(
                LinearGradient(colors: [.white, .purple], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        Image("BackgroundImage")
                            .resizable()
                            .scaledToFill()
                            .opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                        
                        
                    )
            )
        }
    }
    
    



   private func saveContext() {
       do {
           try context.save()
       } catch {
           print("Failed to save context: \(error)")
       }
   }
}
