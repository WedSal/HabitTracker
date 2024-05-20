//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-19.
//

import SwiftUI
import CoreData


struct AddHabitView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var habitStore: HabitStore
    @State private var habitName = ""
    @State private var selectedDates = Date()
    @State private var plannedDates = [Date]()
    @State private var showToast = false
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Name", text: $habitName)
                DatePicker("Select Date", selection: $selectedDates, displayedComponents: .date)
                Button("Add Date") {
                    plannedDates.append(selectedDates)
                    showToast = true
                }
                if showToast {
                    Text("Date Added!").foregroundColor(.green)
                }
                
                Button("Add Habit") {
                    
                    if !habitName.isEmpty && !plannedDates.isEmpty {
                        habitStore.addHabit(name: habitName, plannedDays: plannedDates)
                                           dismiss()
                    }
                }
            }
            
            .navigationTitle("Add New Habit")
        }
       .background(
            LinearGradient(gradient: Gradient(colors: [.white, .purple]), startPoint: .top, endPoint: .bottom)
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
    
  //  private func addHabit(name: String, plannedDays: [Date]) {
    //        let newHabit = HabitCD(context: context)
      //      newHabit.id = UUID()
        //    newHabit.name = name
          //  newHabit.plannedDays = plannedDays as NSObject
     //       newHabit.completedDays = [] as NSObject
       //     newHabit.currentStreak = 0

         //   do {
           //     try context.save()
         //   } catch {
           //     print("Failed to save habit: \(error)")
          //  }
     //   }
    }
    
    
    

