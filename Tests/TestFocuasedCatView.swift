//
//  TestFocuasedCatView.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 4/17/24.
//

import SwiftUI

struct TestFocuasedCatView: View {
    var catName:String
    @ObservedObject var taskManger = TaskManager()
    var body: some View {
        List{
            if let categorizedTask = taskManger.tasks.first(where: {$0.category == catName}){
                ForEach(categorizedTask.tasks, id: \.id){ task in
                    TaskRow(task: task.taskName, DueDate: "Today", periority: task.priority)
                }
            }
        }
    }
}

#Preview {
    TestFocuasedCatView(catName: "Work")
}
