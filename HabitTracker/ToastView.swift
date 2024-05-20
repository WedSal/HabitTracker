//
//  ToastView.swift
//  HabitTracker
//
//  Created by Weda on 2024-05-12.
//

import SwiftUI

struct ToastView: View {
    var text: String
    @Binding var isShowing: Bool
    
    var body: some View {
        Group {
            if isShowing {
                Text(text)
                    .padding()
                    .background(Color.purple.opacity(0.75))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .opacity(isShowing ? 1.0 : 0.0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            isShowing = false
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
