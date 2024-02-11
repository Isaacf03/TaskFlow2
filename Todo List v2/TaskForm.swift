//
//  TaskForm.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/11/24.
//

import SwiftUI

struct TaskForm: View {
    @EnvironmentObject var taskManager: TaskManager

    @State var taskName: String = ""
    @State var Desc = ""
    @State var DueDate = ""
    @State var NameofTask: String
    @State var SchedualON: Bool
    @State var selectedDate: Date
    @State var Priority: Int
    
    var body: some View {
        NavigationView{
            Form{
                    Section(header: Text("Task")){
                        TextField("Task Name", text: $taskName)
                        TextField("Desc", text: $Desc)
                        Picker("Priority",selection: $Priority){
                            ForEach(1...5, id:\.self){ nums in
                                Text("\(nums)")
                            }
                        }
                        
                    }
                    
                    Section(header: Text("Due Date")) {
                        Toggle("Schedule Time", isOn: $SchedualON )
                        if SchedualON {
                            DatePicker("Desc",selection: $selectedDate, displayedComponents: displayComps())
                        }
                    }
            }
            Button("Save"){
                
            }
            .font(.headline)
                
        }
    
//            .navigationTitle(NameofTask)
//            .frame(maxWidth: .infinity, alignment:.center)

    }
    func displayComps() -> DatePickerComponents{
        return SchedualON ? [.hourAndMinute,.date] : [.date]
    }
    
}

struct TaskForm_Preview: PreviewProvider{
    static var previews: some View{
        TaskForm(NameofTask: "Test", SchedualON: false, selectedDate: Date(), Priority: 5).environmentObject(TaskManager())
    }
}
