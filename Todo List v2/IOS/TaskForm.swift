//
//  TaskForm.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/11/24.
//
#if os(iOS)
import SwiftUI

struct TaskForm_outer: View {
    @State var taskName: String
    @State var Desc: String = ""
    @State var DueDate = ""
    @State var SchedualON: Bool
    @State var selectedDate: Date
    @State var Priority: Int
    var body: some View {
        NavigationView{
            TaskForm(taskName: taskName, SchedualON: SchedualON, selectedDate: selectedDate, Priority: Priority)
            VStack{
                Button("Save"){
                    TaskManager().updateTask(from: taskName)
                }
            }
            
        }
    }
}




struct TaskForm: View {
    @EnvironmentObject var taskManager: TaskManager

    @State var taskName: String
    @State var Desc: String = ""
    @State var DueDate = ""
    @State var SchedualON: Bool
    @State var selectedDate: Date
    @State var Priority: Int
    
    var body: some View {
        Form{
            Section(header: Text("")){
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
    }
    func displayComps() -> DatePickerComponents{
        return SchedualON ? [.hourAndMinute,.date] : [.date]
    }
    
}

struct TaskForm_Previews: PreviewProvider {
    static var previews: some View {
        TaskForm(taskName: "test", SchedualON: false, selectedDate: Date(), Priority: 1)
            .environmentObject(TaskManager()) // Provide a TaskManager instance
    }
}
//
//struct TaskForm_Preview: PreviewProvider{
//    static var previews: some View{
//        
////       Text
////          
//        }
//    }
//}
#endif
