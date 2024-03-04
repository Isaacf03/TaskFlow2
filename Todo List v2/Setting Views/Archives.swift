//
//  Archives.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 3/4/24.
//

import SwiftUI

struct Archives: View {
    @EnvironmentObject var taskManager: TaskManager
    var body: some View {
        NavigationView{
            List{
                
                if taskManager.deletedTask.isEmpty{
                    Text("Nothing here yet")
                }
                else{
                    ForEach(taskManager.deletedTask){ cat in
                        Text(cat.category)
                    }
                    
                }   
            }
            .navigationTitle("Deleted Categories")
        }
    }
}

#Preview {
    Archives().environmentObject(TaskManager())
}
