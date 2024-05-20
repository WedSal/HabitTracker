//
//  Home.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-06.
//

import SwiftUI

struct HomeView: View {
    private var weekDays: [Date] {
        let today = Date()
        return today.allDaysOfWeek()
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter ()
        formatter.dateFormat = "EEE\ndd"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack {
               
                HStack(spacing: 20){
                    ForEach(weekDays, id: \.self) { date in
                        Text(dateFormatter.string(from: date))
                            .frame(width: 60, height: 60)
                            .background(Color.purple.opacity(0.3))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2 ))
                        
                    }
                }
                .padding()
                Spacer()
                
                Text("Build positive Habits & reach your Goals 🏆 ")
                    .font(.custom("Georgia", size: 24))
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                NavigationLink(destination: ContentView ()) {
                    Text("Start your journey 👉🏻")
                        .font(.custom("Georgia", size: 20))
                        .padding()
                        .background(Color.yellow.opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding()
                        
                        
                }
                .padding(.bottom,20)
               
                
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
    }


extension Date {
    func startOfWeek(using calendar: Calendar = Calendar.current) -> Date {
        let components = calendar.dateComponents(([.yearForWeekOfYear, .weekOfYear]), from: self)
        return calendar.date(from: components)!
        
    }
    
    func allDaysOfWeek(using calendar: Calendar = Calendar.current) -> [Date] {
        let startOfWeek = self.startOfWeek(using: calendar)
        return (0..<7).map { calendar.date(byAdding: .day, value: $0, to: startOfWeek)!}
    }
    }
    
   struct Home_Previews: PreviewProvider {
      static var previews: some View {
            HomeView()
        }
    }

