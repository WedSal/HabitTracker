//
//  HabitView.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-19.
//

import SwiftUI
import CoreData

struct HabitView: View {
    @ObservedObject var habit: HabitCD
    var toggleHabit: (UUID, Date) -> Void
    var deleteHabit: () -> Void
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text(habit.name ?? "")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(5)
                .padding(.horizontal)
                .shadow(radius: 3)
            
            HStack{
                Text("Streak: \(habit.currentStreak) 🏆")
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    toggleHabit(habit.id ?? UUID(), Date())
                    
                }) {
                    Image(systemName: habit.isCompleted(on: Date()) ? "checkmark.circle.fill" : "circle" )
                        .foregroundColor(habit.isCompleted(on: Date()) ? .white : .yellow)
                        .font(.title2)
                    
                }
            }
            .padding(.horizontal)
            
            Button(action: {
                deleteHabit()
                
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            
            .padding(.horizontal)
            
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(5)
        
        .shadow(radius: 5)
        
    }
}

extension HabitCD {
    func isCompleted(on date: Date) -> Bool {
        (completedDays as? Set<Date>)?.contains(date) ?? false
    }
}
 
 
  
 
 

