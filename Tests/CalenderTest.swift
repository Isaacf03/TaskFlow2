//
//  CalenderTest.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/11/24.
//

import SwiftUI

struct CalenderTest: View {
    @State var selectedDate: Date = Date()
    var body: some View {
        VStack() {
            Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
                .font(.system(size: 28))
                .bold()
                .foregroundColor(Color.accentColor)
                .padding()
                .animation(.spring(), value: selectedDate)
                .frame(width: 500)
            Divider().frame(height: 1)
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                .padding(.horizontal)
                .datePickerStyle(.graphical)
            Divider()
        }
        .padding(.vertical, 100)
    }
}

#Preview {
    CalenderTest()
}
