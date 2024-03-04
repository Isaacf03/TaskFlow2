//
//  CleanIOSView.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/11/24.
//

import SwiftUI

struct CleanIOSView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var taskManager: TaskManager
    @State var newCategory = ""
    @State var newTask = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                addNewCategory(taskManager: taskManager, newCategory: $newCategory, height: 40, width: .infinity)
                    .frame(height: 45)
                    
                ZStack(alignment:.bottom){
                    List{
                        ForEach(taskManager.tasks){ category in
                            categoryView(categoryName: category.category, taskManager: taskManager, newTaskName: newTask)
                                .frame(height: 200)
                        }
                    }.listStyle(.plain)
                        .refreshable {
//                            taskManager.saveCats()
//                            taskManager.loadCats()
                            print(_taskManager.wrappedValue.tasks)
                    }
                    FloatingButton(presented: false)
                        .padding(.leading, 320)
                        .padding(.bottom)
                }
            }
            .navigationTitle("Categories")
        }
    }
}

//struct CleanIOSView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Wrap `CleanIOSView` inside a preview
//        CleanIOSView().environmentObject(TaskManager())
//    }
//}

//struct FloatingButton: View {
//    @State var presented: Bool
//    @State var superField: String
//    @Environment(\.colorScheme) var colorScheme
//    var body: some View {
//        Spacer()
//        Button("+") {
//            self.presented = true
//        }
//        .foregroundColor(colorScheme == .dark ? .white : .black)
//        .background{
//            Circle()
//                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 1)
//                .frame(width: 60,height: 60)
////                
//        }
//        .sheet(isPresented: $presented){
//            TextView(someText: superField)
//                .presentationDetents([.fraction(0.2),.medium,.large])
//                .presentationDragIndicator(.visible)
//        }
//    }
//    
//}


//
//var body: some View {
//    NavigationView{
//        VStack(alignment:.leading) {
////                Button("Save"){
////                    TaskManager().saveCats()
////                }
////            NavigationView{
////                NavigationLink(destination: TestView()){
////                    Text("enter view")
////                }
////            }
//            addNewCategory(taskManager: taskManager, newCategory: $newCategory, height: 40, width: .infinity)
//                .frame(height: 45)
////            ScrollView{
////                ForEach(taskManager.tasks){ category in
////                    categoryView(categoryName: category.category, taskManager: taskManager)
////z
////                }
////            }
//            
//            List{
//                ForEach(taskManager.tasks){ category in
//                    
////                        Section(header: categoryHeaderView(category: category.category, newTask: $newTask)) {
////                            categoryView(categoryName: category.category)
////                        }
////                            .onAppear(perform: {
////                                taskManager.saveCats()
////                            })
////                        categoryView(categoryName: category.category)
//
//                        categoryView(categoryName: category.category, taskManager: taskManager, newTaskName: newTask)
//                        .frame(height: 200)
//                    
//                }
//                .onMove(perform: { indices, newOffset in
//                    taskManager.moveTask(from: indices, to: newOffset, in: newCategory)
//                })
//            }
//            .listStyle(.plain)
//            .refreshable {
//                taskManager.saveCats()
//                taskManager.loadCats()
//                print(_taskManager.wrappedValue.tasks)
//            }
////                AddButtom()
////                    .onTapGesture {
////                        print("works")
////                    }
////                HStack{
////                    Spacer()
////
////                    Button("+") {
////                        self.ShowingADDpg = true
////                    }
////                    .foregroundColor(colorScheme == .dark ? .white : .black)
////                    .background{
////                        Circle()
////                            .stroke(colorScheme == .dark ? .white : .black, lineWidth: 1)
////                            .frame(width: 60,height: 60)
////
////                    }
////                    .sheet(isPresented: $ShowingADDpg){
////                        SuperTextField(placeholder: Text("test"), text: $superfield)
////                            .presentationDetents([.fraction(0.2),.medium,.large])
////                            .presentationDragIndicator(.visible)
////                    }
////                    .padding(.bottom, 20)
////                    .padding(.trailing,20)
////
////                }
////                FloatingButton(presented: ShowingADDpg, superField: "test")
//
//        }
////            .padding()
//        .background(.green)
//        .navigationTitle("Categories")
//    }
//}
//}
