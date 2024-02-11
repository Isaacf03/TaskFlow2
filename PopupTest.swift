//
//  PopupTest.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/12/24.
//

import SwiftUI
struct PopupTestView: View {
    @State private var isShowingPopup = false
    
    var body: some View {
    
        Button("Show Popup") {
            self.isShowingPopup = true
        }
        .sheet(isPresented: $isShowingPopup) {
            PopupView(isShowingPopup: self.$isShowingPopup)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

struct PopupView: View {
    @Binding var isShowingPopup: Bool
    
    var body: some View {
        VStack {
            Text("This is a Popup View")
                .font(.title)
                .padding()
            
            Button("Close") {
                // Close the popup
                dismiss()
            }
            .padding()
        }
        .frame(height: 200)
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private func dismiss() {
        // Dismiss the popup by setting the state variable to false
        // This will close the popup view
        isShowingPopup = false
    }
}

#Preview {
    PopupTestView()
}
