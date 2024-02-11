//
//  SchedualView.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/9/24.
//

import SwiftUI
import Foundation

struct SchedualView: View {
    var body: some View {
        HStack{
            Text("\(getCurrentDay())")
        }
        .navigationTitle(getCurrentDay())
    }
    func getCurrentDay() -> String {
         let today = Date()
         let calendar = Calendar.current
        let dayComponent = calendar.component(.weekday, from: today)
        let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
         return weekdays[dayComponent-1]
     }
}

#Preview {
    SchedualView()
}
