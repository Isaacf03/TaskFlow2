//
//  TestMain.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/8/24.
//

import SwiftUI

struct MainiOSView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TabView{
            IOSView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait")
                }
            CalenderTest()
                .tabItem {
                    Image(systemName: "calendar")
                }
            SchedualView()
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
        }
        .accentColor(colorScheme == .dark ? .white : .black)
    }
}

struct MainView_preview: PreviewProvider{
    static var previews: some View{
        MainiOSView().environmentObject(TaskManager())
    }
}
