#if os(iOS)
import SwiftUI
import Foundation

struct SettingsView: View {
    @ObservedObject var vm: SettingsViewModel
    @EnvironmentObject var taskManager: TaskManager
    @State private var showAltert = false
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Aesthetic")) {
                    NavigationLink(destination: ColorSchemeView()) {
                        Text("Color Scheme")
                    }
                    NavigationLink("App Icon", destination: TextView())
                    NavigationLink("Behaviors", destination: Behaviors(top: $vm.settings.TopOrBottom, bar: $vm.settings.CategoryBar, floatingBtn: $vm.settings.floatingBtn))
                }
                Section(header: Text("Archive")) {
                    NavigationLink("Deleted Categories", destination: Archives())
                    Toggle(isOn: $vm.settings.ArchiveEnabled) {
                        if vm.settings.ArchiveEnabled{
                            Text("Turn Off Archive")
                        } else{
                            Text("Turn On Archive")
                        }
                    }
                }
                Section(header: Text("Data")) {
                    Text("Privacy")
                    Button("Clear Everything"){
                        showAltert = true
                    }
                    .alert(isPresented: $showAltert){
                        Alert(title: Text("Are you sure you want to Clear All?"),
                              primaryButton: .default(
                                Text("No")
                              ),
                              secondaryButton: .destructive(
                                Text("CLEAR"),
                                action: taskManager.clearAll
                              )
                              
                        )
                    }
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
        
        return SettingsView(vm: settingsViewModel).environmentObject(TaskManager())
    }
}

struct Behaviors: View {
    @Binding var top: Bool
    @State var hiddenKey: Bool = false
    @Binding var bar: Bool
    @Binding var floatingBtn: Bool
    @StateObject var svm = SettingsViewModel(settings: SettingsModel())
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("Category Bar")) {
                    //                    Toggle(isOn: $bar) {
                    //                        Text("Category Bar")
                    //                    }
                    Toggle("Category Bar", isOn: $bar)
                    
                    Toggle("Top or Bottom", isOn: $top)
                    Toggle(isOn: $hiddenKey){
                        if hiddenKey == true{
                            Text("Hiding Keybord after Adding Category")
                                .font(.subheadline)
                        } else{
                            Text("Showing Keybord after Adding Category")
                                .font(.subheadline)
                        }
                        
                    }
                    Menu("Actitons") {
                        HStack{
                            Text("works")
                            Text("2")
                        }
                    }
                }
                .onChange(of: bar) { old, newValue in
                    floatingBtn = !newValue
                }
                .onChange(of: floatingBtn) { old, newValue in
                    bar = !newValue
                }
                Section(header: Text("Floating Button")){
                    Toggle(isOn: $floatingBtn) {
                        Text("Floating Button")
                    }
                }
            }
            
        }
        .navigationTitle("Behaviors")
        
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
    
    @UserDefaulted(key: "CategoryBar", defaultValue: true)
    var CategoryBar: Bool
    
    @UserDefaulted(key: "floatingBtn", defaultValue: false)
    var floatingBtn: Bool
    
}



class SettingsViewModel: ObservableObject{
    @Published var settings: SettingsModel
    init(settings: SettingsModel) {
        self.settings = settings
    }
    
    
    func opps(){
        if settings.CategoryBar{
            settings.floatingBtn = false
        }
        if !settings.CategoryBar{
            settings.floatingBtn = true
        }
    }
    
}

#endif
