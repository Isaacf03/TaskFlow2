//
//  ContentView.swift22
//  Todo List v2
//
//  Created by Isaac Fajardo on 1/8/24.
//

#if os(iOS)
import SwiftUI

struct IOSView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var taskManager: TaskManager
//    change to enviromentObject and add to the main view
    @ObservedObject var settingsVm: SettingsViewModel
    @State var formview: Bool = false
    @State var newCategory = ""
    @State var newTask = ""
    @State var ShowingADDpg = false
    @State var superfield = ""
    @State var isPresssed = false
    @State var showOptions = false
    @State var cat_name = ""
    @State var bigFrame = false
    @State var expanded = false
    var body: some View {
        NavigationView{
            if !expanded{
                VStack(alignment:.leading){
                    
        //                Enter a new Category Bar
                    if settingsVm.settings.CategoryBar{
                        if settingsVm.settings.TopOrBottom == false{
                            addNewCategory(taskManager: taskManager, newCategory: newCategory, height: 40, width: .infinity)
                                .frame(height: 45)
                                .padding(.horizontal)
                        }
                    }
        //              The List view for the
                    List{
                        ForEach(taskManager.tasks){ category in
                            categoryView(categoryName: category.category, expanded: $expanded, taskManager: taskManager, newTaskName: newTask)
                                .frame(height: 200)
                        }
                        .onDelete{ indexSet in
                            taskManager.removeCategory(atOffsets: indexSet)
                        }
                        .onMove(perform: taskManager.move)

                    }
                    .scrollIndicators(.hidden)

                    .toolbar{
                        HStack{
                            if taskManager.tasks.count != 0{
                                Text("\(taskManager.tasks.count)")
                                    .font(.subheadline)
                            }
                            EditButton()
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        taskManager.saveCats()
                        print(_taskManager.wrappedValue.tasks)
                        print("deleted cats",_taskManager.wrappedValue.deletedTask)
                        taskManager.loadCats()
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
                    if settingsVm.settings.CategoryBar{
                        if settingsVm.settings.TopOrBottom == true{
                            addNewCategory(taskManager: taskManager, newCategory: newCategory, height: 40, width: .infinity)
                                .frame(height: 45)
                                .padding(.horizontal)
                                .padding(.bottom)
                        }
                    } else{
                        HStack{
                            FloatingButton(presented: false)
                                .padding(.trailing)
                                .padding()
                        }
                    }
                }
                .navigationTitle("Categories")
            /// Not Expaned
            }
            
            else{
                //Change this to navigationview
                
                FocusedCatView(catName: cat_name, presented: false)
            }
        
        }
    }
}
 
struct IOSView_preview: PreviewProvider{
    static var previews: some View{
//        MainiOSView().environmentObject(TaskManager())
        IOSView(settingsVm: SettingsViewModel(settings: SettingsModel())).environmentObject(TaskManager())
    }
}

//Outer white box
struct categoryView: View {
    var categoryName: String
    @Binding var expanded: Bool
    @ObservedObject var taskManager: TaskManager
//    @EnvironmentObject var taskManger: TaskManager
    @Environment(\.colorScheme) var colorScheme
    @State var newTaskName = ""
    @State var updatedTask = ""
    @State var test: Bool = false
    @State var presentedF: Bool = false

    var body: some View {
        VStack{
            if let categorizedTask = taskManager.tasks.first(where: { $0.category == categoryName}){
                
                categoryHeaderView(category: categoryName, expanded: $expanded, presented: $presentedF, viewModel: taskManager, newTask: $newTaskName)
                
                ScrollView{
                    ForEach(categorizedTask.tasks, id: \.id) { task in
                        TaskRow(task: task.taskName, DueDate: "\(task.dueDate.formatted(date:.numeric,time: .omitted))", periority: 1)
                            .sheet(isPresented: $test){
                                TaskForm_outer(taskName: task.taskName, SchedualON: task.isScedualed, selectedDate: task.dueDate, Priority: task.priority)
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                            }
        
                            .padding(.top, 6)
                            .onLongPressGesture {
                                test = true
                            }
                        
                    }
                    .onDelete{ indexSet in
                        taskManager.removeCategory(atOffsets: indexSet)
                    }
                    .onMove(perform: taskManager.move)
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

struct addNewCategory: View {
    @ObservedObject var taskManager: TaskManager
    @State var newCategory: String
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
                    TextField("Enter A New Category", text: $newCategory)
                        .textFieldStyle(.plain)
                        .frame(height: height)
                        .accentColor(colorScheme == .dark ? .white : .black)
                        .padding(.leading)
                        .onSubmit {
                            if !newCategory.isEmpty {
                                taskManager.addCategory(name: newCategory)
                                newCategory = ""
                                taskManager.saveCats()
                            }

                        }
                    Button("Add"){
                        if !newCategory.isEmpty{
                            taskManager.addCategory(name: newCategory)
                            newCategory = ""
                            taskManager.saveCats()

                        }
                    }
                    .padding(.trailing)

                    Button("Clear"){
                        newCategory = ""
//                        taskManager.clearAll()
//                        taskManager.addToDeletedTask()
//                        taskManager.saveCats()
                    }
                    .padding(.trailing)

                }.foregroundColor(colorScheme == .dark ? .white : .black)
            }
        }
    }
}

struct categoryHeaderView: View {
    @State var category: String
    @Binding var expanded: Bool
    @Binding var presented: Bool
    @ObservedObject var viewModel = TaskManager()
    @Binding var newTask: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack{
            TextField("Enter Name",text: $category)
                .font(.title3)
                .onSubmit {
                    print("name changed")
                }
            TextField("Enter Task", text: $newTask)
                .textFieldStyle(PlainTextFieldStyle())
                .onSubmit {
                    viewModel.addTask(name: newTask, to: category)
                    newTask = ""
                    viewModel.saveCats()
                }

            NavigationLink(""){
                FocusedCatView(catName: category, presented: presented)
            }

            .frame(width: 20)

                
//            Image(systemName: "arrow.down.left.and.arrow.up.right")
//                .onTapGesture {
//                    expanded.toggle()
//                }
            #if os(macOS)
                .onKeyPress(keys:[.return]){_ in
                    viewModel.addTask(name: newTask, to: category)
                    newTask = ""
                    return .handled
                }
            #endif

            #if os(iOS)
//            Button("ADD"){
//                viewModel.addTask(name: newTask, to: category)
//                newTask = ""
//            }
//            .padding(.trailing)
//            .foregroundColor(colorScheme == .dark ? .white : .black)
            #endif
            
        }
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

struct FocusedCatView: View {
    var catName: String
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var tm: TaskManager
    @State private var taskText: String = ""
    @State var presented: Bool
    var body: some View {
        List{
            if let catTask = tm.tasks.first(where: {$0.category == catName }){
                ForEach(catTask.tasks, id: \.id){ task1 in
                    TaskRow(task: task1.taskName, DueDate: "", periority:task1.priority )
                        .padding(.vertical,5)
                        .padding(.horizontal)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 1)
                        )
                        .listRowSeparator(.hidden)
                        .sheet(isPresented: $presented) {
                            ComingSoon()
                                .presentationDetents([.medium])
                        }
                }.onDelete{ indexSet in
                    tm.deleteTasks(at: indexSet, from: catName)
                }
                .onLongPressGesture {
                    self.presented = true
                }
                
                
            }
        }
        .navigationTitle(catName)
        .listStyle(.plain)
        .toolbar{
            EditButton()
        }
    }
    func move(from source: IndexSet, to destination: Int){
        if let catTask = tm.tasks.first(where: {$0.category == catName}){
            
        }
        tm.tasks.move(fromOffsets: source, toOffset: destination)
    }
}

struct focus_preview: PreviewProvider{
    static var previews: some View{
    
        FocusedCatView(catName: "Work", presented: false).environmentObject(TaskManager())
            
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
    var periority: Int
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
//    let vm: SettingsViewModel
    @Published var tasks: [CategorizedTask] = []
    @Published var deletedTask: [CategorizedTask] = []
      func didSet(){
          saveCats()
      }
      private let taskKey = "tasks"
      
    init(){
          loadCats()
      }
      
/// Category Functions
    
    func addCategory(name:String){
        /// This Function adds a new Category to the List
        let newCategory = CategorizedTask(category: name, tasks: [])
        if !tasks.contains(where: {$0.category == newCategory.category}){
            tasks.append(newCategory)
            saveCats()
        }
        
    }
    func removeCategory(atOffsets offsets: IndexSet) {
        deletedTask.append(contentsOf: offsets.map {tasks[$0]})
        tasks.remove(atOffsets: offsets)
        saveCats()

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
    
    func returnTaks(catName:String){
        if !tasks.contains(where: {$0.category == catName}){
            return
        }
    }
    
    
//  func moveCat(from source: IndexSet, to destination: Int, in category: String){
//        objectWillChange.send()
//        if let fistIndex = source.first, let categoryIndex = tasks.firstIndex(where: { $0.category == category }){
//            let task = tasks
//        }
//
//    }
    
/// Task Functions
    func addTask(name: String, to categoryName: String) {
        // checks if its empty and doesnt add it
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {return}
        if let index = tasks.firstIndex(where:  { $0.category == categoryName}){
            let newTask = Task(taskName: name, isCompleted: false, isScedualed: false, priority: 1, dueDate: Date())
            DispatchQueue.main.async {
                self.tasks[index].tasks.append(newTask)
                self.saveCats()
            }
        }
    }
    
    func deleteTasks(at offsets: IndexSet, from category: String) {
        if let index = tasks.firstIndex(where: { $0.category == category }) {
            tasks[index].tasks.remove(atOffsets: offsets)
        }
        saveCats()
    }
    func updateTask(from category: String){
        if let index = tasks.firstIndex(where: { $0.category == category}){
            print(tasks[index].tasks)
        }
        
    }
    
    
/// General Functions
    func move(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
        
    }
    
    func clearAll(){
//        tasks.insert(contentsOf: tasks, at: deletedTask)
        tasks.removeAll()
        saveCats()
    }
}
#endif
