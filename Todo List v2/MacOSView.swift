//
//  MacOSView.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 1/25/24.
//
#if os(macOS)
import SwiftUI

struct MacOSView: View {
    var body: some View {

            HSplitView(content: {
                Text("Top")
                Text("Bottom")
            })
        
    }
}

#Preview {
    MacOSView()
}
#endif
