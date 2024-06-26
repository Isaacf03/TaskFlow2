//
//  TestMain.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/8/24.
//

#if os(iOS)
import SwiftUI

struct MainiOSView: View {
    @Environment(\.colorScheme) var colorScheme
    let settingsModel = SettingsModel()
    let settingsViewModel = SettingsViewModel(settings: SettingsModel())
    var body: some View {
        TabView{
            IOSView(settingsVm: settingsViewModel)
                .tabItem {
                    Image(systemName: "list.bullet.rectangle.portrait")
                }

//            Coming Soon
            ComingSoon()
                .tabItem {
                    Image(systemName: "calendar")
                }
            ComingSoon()
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                }
            SettingsView(vm: settingsViewModel)
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
#endif
