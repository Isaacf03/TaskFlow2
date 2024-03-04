//
//  ContentView.swift22
//  Todo List v2
//
//  Created by Isaac Fajardo on 1/8/24.
//

import SwiftUI

struct IOSView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var taskManager: TaskManager
//    change to enviromentObject and add to the main view
    @ObservedObject var settingsVm: SettingsViewModel
    @State var newCategory = ""
    @State var newTask = ""
    @State var ShowingADDpg = false
    @State var superfield = ""
    @State var isPresssed = false
    @State var showOptions = false
    
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                if settingsVm.settings.TopOrBottom == false{
                    addNewCategory(taskManager: taskManager, newCategory: $newCategory, height: 40, width: .infinity)
                        .frame(height: 45)
                        .padding(.horizontal)
                        
                }
                ZStack(alignment:.top){
    
                    List{
                        ForEach(taskManager.tasks){ category in
                            categoryView(categoryName: category.category, taskManager: taskManager, newTaskName: newTask)
                                .frame(height: 200)
                        }
                        .onDelete{taskManager.tasks.remove(atOffsets: $0)}
                    }
                    .toolbar{
                        EditButton()
                    }
                    .listStyle(.plain)
                        .refreshable {
//                            taskManager.saveCats()
                            taskManager.loadCats()
                            print(_taskManager.wrappedValue.tasks)
                    }
                }
//                HStack{
//                    Spacer()
//                    SwipeOptionBTN(wasPressed: $isPresssed)
//                        .onTapGesture {
//                            isPresssed.toggle()
//                        }
//                        .sheet(isPresented: $isPresssed, content: {
//                            TaskForm(NameofTask: "test", SchedualON: true, selectedDate: Date(), Priority: 5)
//                                .presentationDetents([.fraction(0.52)])
//                                .presentationDragIndicator(.visible)
//                        })
//                        .padding(.trailing)
//                        .padding(.bottom)
//                    
////                    Button("Showsheet"){
////                        ShowingADDpg.toggle()
////                    }
////                    .sheet(isPresented: $ShowingADDpg, content: {
////                        TaskForm(NameofTask: "test", SchedualON: true, selectedDate: Date(), Priority: 5)
////                            .presentationDetents([.fraction(0.4)])
////                            .presentationDragIndicator(.automatic)
////                    })
//                }
                if settingsVm.settings.TopOrBottom == true{
                    addNewCategory(taskManager: taskManager, newCategory: $newCategory, height: 40, width: .infinity)
                        .frame(height: 45)
                        .padding(.bottom)
                }
            }
        
            .navigationTitle("Categories")
            
        }
    }
}
    


struct IOSView_preview: PreviewProvider{
    static var previews: some View{
//        MainiOSView().environmentObject(TaskManager())
        IOSView(settingsVm: SettingsViewModel(settings: SettingsModel())).environmentObject(TaskManager())
    }
}

struct FloatingButton: View {
    @State var presented: Bool
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Spacer()
        Button("+") {
            self.presented.toggle()
        }
        .frame(width: 60,height: 60)
        .sheet(isPresented: $presented){
            TextView()
                .presentationDetents([.fraction(0.2),.medium,.large])
                .presentationDragIndicator(.visible)
        }
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .background{
            Circle()
                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 1)
                .frame(width: 60,height: 60)
                .onTapGesture {
                    self.presented = true
                }
                
        }
    }
    
}

struct addNewCategory: View {
    @ObservedObject var taskManager: TaskManager
    @Binding var newCategory: String
    @State var height: CGFloat
    @State var width: CGFloat
    @State var SearchClear: Bool = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.secondary.opacity(0.2))
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
                
                HStack{
                    TextField("Enter A New Category", text: $newCategory, onCommit: {
                                    if !newCategory.isEmpty {
                                        taskManager.addCategory(name: newCategory)
                                        newCategory = "" // Clear the TextField after adding
                                    }
                                })
                        .textFieldStyle(.plain)
                        .frame(height: height)
                        .accentColor(colorScheme == .dark ? .white : .black)
                        .multilineTextAlignment(.center)
                    Button("Add"){
                        if !newCategory.isEmpty{
                            taskManager.addCategory(name: newCategory)
                            newCategory = ""
                        }
                    }
                    .padding(.trailing)

                    Button("Clear"){
                        taskManager.clearAll()
                    }
                    .padding(.trailing)

                }.foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
    }
}

struct SuperTextField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
    
}

struct categoryHeaderView: View {
    @State var category: String
    @ObservedObject var viewModel = TaskManager()
    @Binding var newTask: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack{
            TextField("Enter Changed Name",text: $category)
                .font(.title3)
            TextField("Enter new Task", text: $newTask)
                .textFieldStyle(PlainTextFieldStyle())
            #if os(macOS)
                .onKeyPress(keys:[.return]){_ in
                    viewModel.addTask(name: newTask, to: category)
                    newTask = ""
                    return .handled
                }
            #endif

            #if os(iOS)
            Button("ADD"){
                viewModel.addTask(name: newTask, to: category)
                newTask = ""
            }
            .padding(.trailing)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            #endif
            
        }
    }
}

struct categoryView: View {
    var categoryName: String
    @ObservedObject var taskManager: TaskManager
//    @EnvironmentObject var taskManger: TaskManager
    @Environment(\.colorScheme) var colorScheme
    @State var newTaskName = ""

    var body: some View {
//        VStack{
//            List{
//                ForEach(taskManager.tasks){ task in
//                    Text(task.category)
//                    
//                }
//            }
//            .refreshable {
//                taskManager.loadCats()
//            }
//        }
        VStack{
            if let categorizedTask = taskManager.tasks.first(where: { $0.category == categoryName}){
                
                categoryHeaderView(category: categoryName, viewModel: taskManager, newTask: $newTaskName)
                ScrollView{
                    ForEach(categorizedTask.tasks, id: \.id) { task in
                        
                        NavigationLink(destination: TaskForm(NameofTask: task.taskName, SchedualON: false, selectedDate: Date(), Priority: 5) ) {
                            TaskRow(task: task.taskName, DueDate: "\(task.dueDate.formatted(date:.numeric,time: .omitted))")
                                .padding(.top, 6)
                        }
                        .buttonStyle(.plain)

                    }
                    .onMove(perform: { indices, newOffset in
                        withAnimation {
                            taskManager.moveTask(from: indices, to: newOffset, in: categoryName)
                        }
                    })
                }
                .scrollIndicators(.hidden)
            }
            
        }
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10)
                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 1)
                
                .padding(.all,-5)
                .padding(.horizontal, -10)

        )
    }
}

struct TextView:View {
    @ObservedObject var tm = TaskManager()
    var body: some View {
        ForEach(tm.tasks, id: \.id){ cat in
            Text(cat.category)
        }
        
    }
}

struct TaskRow:View {
    var task: String
    var DueDate: String
    @ObservedObject var taskManager = TaskManager()
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(task)
                    .font(.headline)
                    
                Text("Due Date: \(DueDate)")
                    .font(.caption)
            }
            Spacer()
            Circle()
                .frame(width: 17, height: 17)
            Image(systemName: "info.circle")
            
        }
    }
}

struct MiniFormView:View {
    @State var text: String = ""
    var body: some View {
        NavigationView{
            Form{
                Section("Task Row") {
                    TextField("Test", text: $text)
                    TextField("Test", text: $text)
                    TextField("Test", text: $text)

                }
            }
        }
    }
}






//Model
struct Task: Identifiable, Codable{
    var id = UUID()
    var taskName: String
    var isCompleted: Bool
    var isScedualed: Bool
    var priority: Int
    var dueDate: Date
    
}

struct CategorizedTask:Identifiable,Codable{
    
    var id = UUID()
    var category: String
    var tasks: [Task]
}

//ViewModel
class TaskManager: ObservableObject{
    @Published var tasks: [CategorizedTask] = []
      func didSet(){
          saveCats()
      }
      private let taskKey = "tasks"
      
      init(){
          loadCats()
      }
      
    
    func addCategory(name:String){
        let newCategory = CategorizedTask(category: name, tasks: [])
        if !tasks.contains(where: {$0.category == newCategory.category}){
            tasks.append(newCategory)
//            saveCats()
        }
        
    }
//    func removeCategory(){
//        if tasks.contains(where: {$0.category == task.})
//    }
    
    func addTask(name: String, to categoryName: String) {
        // checks if its empty and doesnt add it
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
        if let index = tasks.firstIndex(where:  { $0.category == categoryName}){
            let newTask = Task(taskName: name, isCompleted: false, isScedualed: false, priority: 0, dueDate: Date())
            DispatchQueue.main.async {
                self.tasks[index].tasks.append(newTask)
//                self.saveCats()
            }
        }
    }
    
    func moveTask(from source: IndexSet, to destination: Int, in category: String) {
        objectWillChange.send()
        if let firstIndex = source.first, let categoryIndex = tasks.firstIndex(where: { $0.category == category }) {
            let task = tasks[categoryIndex].tasks.remove(at: firstIndex)
            tasks[categoryIndex].tasks.insert(task, at: destination)
        }
    }
//    func moveCat(from source: IndexSet, to destination: Int, in category: String){
//        objectWillChange.send()
//        if let fistIndex = source.first, let categoryIndex = tasks.firstIndex(where: { $0.category == category }){
//            let task = tasks
//        }
//        
//    }
    
    
    func clearAll(){
        tasks.removeAll()
    }
    func deleteTasks(at offsets: IndexSet, from category: String) {
        if let index = tasks.firstIndex(where: { $0.category == category }) {
            tasks[index].tasks.remove(atOffsets: offsets)
        }
//        saveCats()
    }

    func saveCats(){
        if let encodedData = try? JSONEncoder().encode(tasks){
            UserDefaults.standard.set(encodedData, forKey: taskKey)
        }
    }
    
    func loadCats(){
        if let savedTasks = UserDefaults.standard.object(forKey: "tasks") as? Data {
            if let decodedTasks = try? JSONDecoder().decode([CategorizedTask].self, from: savedTasks){
                self.tasks = decodedTasks
            }
        }
    }
    
}
