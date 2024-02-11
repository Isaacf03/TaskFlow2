//
//  Settings.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/8/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Aesthetic")) {
                    NavigationLink(destination: ColorSchemeView()){
                        Text("Color Scheme")
                    }
                    Text("App Icon")
                }
                Section(header: Text("Data")){
                    Text("Privacy")
                    Text("Reset/Clear")
                    Text("Account")
                    
                    
                    
                }
                    
            }
            .navigationTitle("Settings")

        }
        
    }
}

#Preview {
    SettingsView()
}

struct ColorSchemeView: View {
    var body: some View {
        CustomColor
        List{
            ForEach(1...10, id: \.self){ num in
                Text("\(num)")
            }
            
            
            .navigationTitle("Color Picker")
            
        }
    }
    
    var CustomColor: some View{
        VStack {
            Text("Please enter a rgb value or Hex color ")
        }
    }
}
