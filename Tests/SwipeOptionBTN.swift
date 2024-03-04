//
//  SwipeOptionBTN.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 2/25/24.
//

import SwiftUI


struct SwipeOptionBTN: View {
    @Binding var wasPressed: Bool
    @State private var showOptions = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Spacer()

//        Final Test View ??
        Button(action: {
            wasPressed.toggle()
        }, label: {
            Text("+")
        })
        .padding()
        .foregroundColor(colorScheme == .dark ? .black : .white)
        .frame(width: 60,height: 60)
        .background{
            RoundedRectangle(cornerRadius: 60)
        }
        .contextMenu(){
            // Menu items
            Button(action: {
                // Action for option 1: Add Category
                // Implement your logic here
            }) {
                Text("Add Category")
            }
            Button(action: {
                // Action for option 2: Add New Task
                // Implement your logic here
            }) {
                Text("Add New Task")
            }
            Button(action: {
                // Action for option 3: Add Task
                // Implement your logic here
            }) {
                Text("Add Task")
            }
        }

        
//        Circle()
//            .frame(width: 60,height: 60)
//            .overlay{
//                ZStack{
//                    Text("+")
//                        .foregroundColor(isPresssed ? .black : .white)
//                    if showOptions{
//                        Color.white.opacity(0.8)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .edgesIgnoringSafeArea(.all)
//                            .onTapGesture {
//                                withAnimation(.easeOut(duration: 0.3)) {
//                                    showOptions.toggle()
//                                }
//                            }
//                        VStack{
//                            Text("New Cat")
//                            Text("New Task")
//                            Text("Add Task")
//                        }
//                        .padding()
//                        .background(Color.black.opacity(0.3))
//                        .cornerRadius(10)
//                        .frame(width: 120,height: 100)
//                        .padding(.trailing,180)
//                    }
//                }
//            }
//            .onLongPressGesture(pressing: {pressing in
//                self.isPresssed = pressing
//            }){
//                withAnimation {
//                    showOptions.toggle()
//                }
//            }
//            .onTapGesture {
//                ShowingADDpg.toggle()
//                print(ShowingADDpg)
//            }
//            .sheet(isPresented: $ShowingADDpg, content: {
//                TaskForm(NameofTask: "test", SchedualON: true, selectedDate: Date(), Priority: 5)
//                    .presentationDetents([.fraction(0.4)])
//                    .presentationDragIndicator(.automatic)
//            })
        
// Second Test View
//        Circle()
//            .frame(width: 60,height: 60)
//            .overlay{
//                ZStack{
//                    Text("+")
//                        .foregroundColor(isPresssed ? .black : .white)
//                    if showOptions{
//                        Color.white.opacity(0.8)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .edgesIgnoringSafeArea(.all)
//                            .onTapGesture {
//                                withAnimation(.easeOut(duration: 0.3)) {
//                                    showOptions.toggle()
//                                }
//                            }
//                        VStack{
//                            Text("New Cat")
//                            Text("New Task")
//                            Text("Add Task")
//                        }
//                        .padding()
//                        .background(Color.black.opacity(0.3))
//                        .cornerRadius(10)
//                        .frame(width: 120,height: 100)
//                        .padding(.trailing,180)
//                    }
//                }
//            }
//            .onLongPressGesture(pressing: {pressing in
//                self.isPresssed = pressing
//            }){
//                withAnimation {
//                    showOptions.toggle()
//                }
//            }
//            .contextMenu(){
//                // Menu items
//                Button(action: {
//                    // Action for option 1: Add Category
//                    // Implement your logic here
//                }) {
//                    Text("Add Category")
//                    Image(systemName: "folder.badge.plus")
//                }
//                Button(action: {
//                    // Action for option 2: Add New Task
//                    // Implement your logic here
//                }) {
//                    Text("Add New Task")
//                    Image(systemName: "plus.square.on.square")
//                }
//                Button(action: {
//                    // Action for option 3: Add Task
//                    // Implement your logic here
//                }) {
//                    Text("Add Task")
//                    Image(systemName: "plus.circle")
//                }
//            }
//        ZStack {
//            Circle()
//                .frame(width: 60,height: 60)
//                .overlay{
//                    Text("+")
//                        .foregroundColor(isPresssed ? .black : .white)
//                }
//                .onLongPressGesture(pressing: { pressing in
//                    self.isPresssed = pressing
//                }, perform: {
//                    withAnimation {
//                        showOptions.toggle()
//                    }
//                    print("2")
//            })
//// End of Circle
//            if showOptions{
//                Color.white.opacity(0.8)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        withAnimation(.easeOut(duration: 0.3)) {
//                            showOptions.toggle()
//                        }
//                    }
//                
//                VStack{
//                    Text("New Cat")
//                    Text("New Task")
//                    Text("Add Task")
//                }
//                .padding()
//                .background(Color.black.opacity(0.3))
//                .cornerRadius(10)
//                .multilineTextAlignment(.center)
//                .padding(.trailing,60)
//                
//                
//            }
//            
//            
//            
//        }
        
    }
}

struct SwipeBtn_Previews: PreviewProvider {
    static var previews: some View {
        @State var testing = false
        SwipeOptionBTN(wasPressed: $testing)
    }
}
