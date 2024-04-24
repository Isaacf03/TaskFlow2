//
//  Archives.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 3/4/24.
//
#if os(iOS)

import SwiftUI

struct Archives: View {
    @EnvironmentObject var taskManager: TaskManager
    var body: some View {
        NavigationView{
            if taskManager.deletedTask.isEmpty{
                Text("No Deleted Categories Yet :(")
            }
            else{
                List{
                    ForEach(taskManager.deletedTask){ cat in
//                        Text(cat.category)
                        NavigationLink(cat.category, destination: DeletedTasks())
                    }
                }
                
            }
        }
        .navigationTitle("Deleted Categories")
    }
}


struct DeletedTasks: View{
    @EnvironmentObject var taskManger: TaskManager
    var body: some View{
        ForEach(taskManger.deletedTask){ cat in
            ForEach(cat.tasks){ task in
                Text(task.taskName)
                
            }
        }
    }
}


#Preview {
    Archives().environmentObject(TaskManager())
}
#endif
