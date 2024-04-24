//
//  ScheduleViewTest.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/27/24.
//

import SwiftUI

struct ScheduleViewTest: View {
    @State private var date = Date()
    var body: some View {
        
        HStack{
            Image(systemName: "chevron.left")
                .padding(.leading)
            Spacer()
            VStack {
                Text("Today")
                DatePicker(
                    "", selection: $date,
                        displayedComponents: [.date]
                    )
                .datePickerStyle(.compact)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.trailing)
        }
        ScrollView{
            Divider()
            HStack {
                ForEach(1...12,id: \.self){ num in
                    HStack(spacing:160){
                        Text("\(num)")
                        Divider()
                    }
                }
                Spacer()
            }
            .scrollTargetLayout()
        }
            
            
            
        
    }
}

#Preview {
    ScheduleViewTest()
}
