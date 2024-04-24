//
//  ViewTester.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 1/18/24.
//
#if os(iOS)
import SwiftUI

struct UITestP1View: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView{
            VStack{
                NewCatFieldView()
                List{
                    ForEach(0...3, id: \.self){ nums in
                        BigGroupView()
                            .padding(.vertical,5)
                            .frame(height: 200)
                        
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("TaskFlow")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
            
        UITestP1View()
//        TestTaskrowView()
//        BigGroupView()
}


struct BigGroupView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
    
        VStack {
            Section(header: Text("Category Name").multilineTextAlignment(.leading) ){
                    ScrollView{
                        NavigationLink(destination: textView(text: "1")) {
                            TestTaskrowView()
                        }
                        .foregroundColor(.white)
                        TestTaskrowView()
                        TestTaskrowView()
                        TestTaskrowView()

                    

                    }
                    .listStyle(.plain)
            }
        }
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10)
                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 1)
                
                .padding(.all,-5)

        )
        .padding(.vertical,5)
    }
}

struct textView: View {
    @State var text: String
    var body: some View {
        Text(text)
    }
}


struct TestTaskrowView: View{
    /// This a test view for the task row in the main project
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        HStack {
            VStack{
                Text("Task")
                    .font(.headline)
                    .padding(.leading,-15)
                Text("Due Date")
                    .font(.caption)
            }
            .multilineTextAlignment(.leading)
            Spacer()
            Circle()
                .frame(width: 17, height: 17)
            Image(systemName: "info.circle")
            
        }
//        .overlay( /// apply a rounded border
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(.black, lineWidth: 1)
//                .frame(height: 140)
//            
//        )
    }
}


struct NewCatFieldView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var emptyString = ""
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(12)
                .foregroundColor(.secondary.opacity(0.4))
                .frame(height: .leastNonzeroMagnitude + 40)
                .padding(.horizontal)
            TextField("Enter a new Category", text: $emptyString)
                .multilineTextAlignment(.center)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .textFieldStyle(.plain)
                .onSubmit {
                    emptyString = ""
                }
            
        }
    }
}


#endif
