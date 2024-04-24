//
//  Todo_List_v2App.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 1/8/24.
//

import SwiftUI

@main
struct Todo_List_v2App: App {
#if os(iOS)
    @StateObject var taskManager = TaskManager()
    @StateObject var svm = SettingsViewModel(settings: SettingsModel())
#endif
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            MainiOSView()
                .onAppear{
                    svm.opps()
                }
            #endif
            
            #if os(macOS)
            MacOSView()

            #endif
        }
        #if os(iOS)
        .environmentObject(taskManager)
        #endif
    }
}
#if os(iOS)
@propertyWrapper
struct UserDefaulted<T: Codable> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let value = try? JSONDecoder().decode(T.self, from: data) {
                return value // Codable type
            } else {
                return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue // Non-Codable type
            }
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}
#endif
