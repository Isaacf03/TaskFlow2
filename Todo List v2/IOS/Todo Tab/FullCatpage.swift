//
//  FullCatpage.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 3/5/24.
//
#if os(iOS)
import SwiftUI

struct FullCatpage: View {
    @State var vm: TaskManager = TaskManager()
    var body: some View {
        NavigationView{
            VStack{
//                Text("Tasks")
                List{
                    ForEach(1...5, id: \.self) { num in
                        TaskRow(task: "\(num)", DueDate: "\(Date().formatted())", periority: num)
                        
                    }
                }
                
                
            }.navigationTitle("Category Name")
        }
    }
}

#Preview {
    FullCatpage()
}
#endif
