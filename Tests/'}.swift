import SwiftUI

struct TestView: View {
    @State private var numList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @ObservedObject var vm = ViewModel()
    @State var entry = ""

    var body: some View {
        NavigationView {
            VStack{
                TextField("Enter New Entry",text: $entry)
                    .textFieldStyle(.plain)
                    .padding(.leading)
                    .onSubmit {
                        vm.addNum(number: entry)
                        entry = ""
                    }
                List{
                    ForEach(vm.numList, id: \.id){ num in
                        Text("\(num.number)")
                    }
                    

                }
                .listStyle(.plain)
    
                List {
                    ForEach(numList, id: \.self) { num in
                        Section(header: HStack{
                            Text("\(num)")
                            Image(systemName: "info")
                        }){
                            NavigationLink(destination: SecondView()) {
                                navLink(text: "\(num)")
                            }
                        }
                    }
                }
                .navigationTitle("Number List")
                .toolbar{
                    ToolbarItem {
#if os(iOS)
                        EditButton()
#endif
                    }
                }
            }
        }
    }
}

struct navLink: View {
    @State var text: String

    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "info.circle")
        }
    }
}

struct SecondView: View {
    var body: some View {
        HStack {
            Text("hello")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct numbser: Identifiable, Codable{
    var id = UUID()
    var number: String
}

class ViewModel: ObservableObject{
    @Published var numList: [numbser] = []
    
    func addNum(number: String){
        let newNumber = numbser(number: number)
        numList.append(newNumber)
    }
}
