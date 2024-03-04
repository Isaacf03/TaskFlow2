//
//  OptionButton.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/24/24.
//

import SwiftUI

struct OptionButton: View {
    @State var showpopup: Bool = false
    @State var textColor: Color = .white
    
    @State private var isPressing = false
    @State private var showOptions = false
    var body: some View {

        Circle()
            .frame(width: 60, height: 60)
            .overlay {
                Text("+")
                    .foregroundColor(isPressing ? Color.black : textColor)
            }
            .scaleEffect(showpopup ? 0.8 : 1.0) // Scale down when tapped
            .animation(.spring()) // Add spring animation
            .onLongPressGesture(pressing: { pressing in
                self.isPressing = pressing
            }, perform: {
                withAnimation {
                    showOptions.toggle()
                }
                print("2")
            })
            
        if showOptions {
            Text("True")
            ZStack {
                Color.white.opacity(0.8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                HStack {
                    Button(action: {
                        // Action for first option
                    }) {
                        Text("Option 1")
                    }
                    Button(action: {
                        // Action for second option
                    }) {
                        Text("Option 2")
                    }
                    Button(action: {
                        // Action for third option
                    }) {
                        Text("Option 3")
                    }
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            }
            .transition(.scale) // Add transition animation
        }
        else{
            Text("false")
        }

    }
}

#Preview {
    OptionButton()
}
