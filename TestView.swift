//
//  TestView.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/29/24.
//

import SwiftUI

struct TestView2: View {
    @ObservedObject var taskManafer = TaskManager()
    @State private var newCategoryName = ""
    @State private var selectedCategoryIndex = 0
    @State private var newTaskName = ""
    var body: some View {
        VStack{
            HStack {
                TextField("Enter new Cat", text: $newCategoryName) {
                    newCategoryName = ""
                }
                .padding(.horizontal)
                
                
                Button("Add"){
                    taskManafer.addCategory(name: newCategoryName)
                    newCategoryName = ""
                }
                
                .padding()
            }
            
            Picker("Select Category", selection: $selectedCategoryIndex){
                ForEach(0..<taskManafer.tasks.count, id: \.self){ index in
                    Text(taskManafer.tasks[index].category).tag(index)
                }
            }
            
        }
    }
}

#Preview {
    TestView2()
}
