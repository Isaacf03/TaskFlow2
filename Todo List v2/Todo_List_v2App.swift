//
//  Todo_List_v2App.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 1/8/24.
//

import SwiftUI

@main
struct Todo_List_v2App: App {
    @StateObject var taskManager = TaskManager()
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            MainiOSView()
                
            #endif
            #if os(macOS)
            MacOSView()

            #endif
        }
        .environmentObject(taskManager)
    }
}
