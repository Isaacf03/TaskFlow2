import SwiftUI
import Foundation

struct SettingsView: View {
    @ObservedObject var vm: SettingsViewModel
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Aesthetic")) {
                    NavigationLink(destination: ColorSchemeView()) {
                        Text("Color Scheme")
                    }
                    NavigationLink("App Icon", destination: TextView())
                    NavigationLink("Behaviors", destination: Behaviors(top: $vm.settings.TopOrBottom))
                }
                Section(header: Text("Archive")) {
                    NavigationLink("Deleted Categories", destination: TextView())
                    Toggle(isOn: $vm.settings.ArchiveEnabled) {
                        Text("Turn Off Archive")
                    }
                }
                Section(header: Text("Data")) {
                    Text("Privacy")
                    Text("Reset/Clear")
                    Text("Account")
                }
                Section(header: Text("Feedback")) {
                    Text("Request Features")
                    Text("Report Bugs")
                    Text("URGENT FIX")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let settingsModel = SettingsModel()
        let settingsViewModel = SettingsViewModel(settings: settingsModel)
        
        return SettingsView(vm: settingsViewModel)
    }
}

struct Behaviors: View {
    @Binding var top: Bool
    
    var body: some View {
        List {
            Section(header: Text("Add Category Bar")) {
                Toggle(isOn: $top) {
                    Text("Top or Bottom")
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}


struct ColorSchemeView: View {
    var body: some View {
        List {
            ForEach(1...10, id: \.self) { num in
                Text("\(num)")
            }
        }
        .navigationTitle("Color Picker")
        .navigationBarItems(trailing: CustomColor)
    }
    
    var CustomColor: some View {
        VStack {
            Text("Please enter an RGB value or Hex color")
        }
    }
}


class SettingsModel: ObservableObject{
    @UserDefaulted(key: "ArchiveEnabled", defaultValue: true)
    var ArchiveEnabled: Bool
    
    @UserDefaulted(key: "TopOrBottom", defaultValue: false)
    var TopOrBottom: Bool
}


class SettingsViewModel: ObservableObject{
    @Published var settings: SettingsModel
    
    init(settings: SettingsModel) {
        self.settings = settings
    }
//    func saveSettings(){
//        let defaults = UserDefaults.standard
//        defaults.set(settings.ArchiveON, forKey: "ArchiveEnabled")
//        defaults.set(settings.TopOrBottom, forKey: "TopOrBottom")
//    }
//    func loadSettings(){
//        let defaults = UserDefaults.standard
//        settings.ArchiveON = defaults.bool(forKey: "ArchiveEnabled")
//        settings.TopOrBottom = defaults.bool(forKey: "TopOrBottom")
//    }
}

