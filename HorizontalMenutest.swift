//
//  HorizontalMenutest.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/25/24.
//
import SwiftUI

import SwiftUI

struct MenuButtonView: View {
    var body: some View {
        Image(systemName: "plus")
            .gesture(longPressGesture)
            .contextMenu {
                HStack {
                    Button(action: {
                        // Add Category action
                        print("Add Category action")
                    }) {
                        Label("Add Category", systemImage: "arrow.up.square")
                    }
                    Button(action: {
                        // Add Task action
                        print("Add Task action")
                    }) {
                        Label("Add Task", systemImage: "plus.square.on.square")
                    }
                    Button(action: {
                        // New Task action
                        print("New Task action")
                    }) {
                        Label("New Task", systemImage: "trash")
                    }
                }
            }
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .onEnded { _ in
                // Handle long press if needed
            }
    }
}

#Preview(body: {
    MenuButtonView()
})
