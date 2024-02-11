//
//  listlist.swift
//  Todo List v2
//
//  Created by Isaac Fajardo on 1/26/24.
//

import SwiftUI

struct ContentView: View {
    let categories = [
        Category(id: 1, name: "Category 1", items: [Item(id: 1, name: "Item 1"), Item(id: 2, name: "Item 2")]),
        Category(id: 2, name: "Category 2", items: [Item(id: 3, name: "Item 3"), Item(id: 4, name: "Item 4")])
    ]

    var body: some View {
        NavigationView {
            List(categories){ category in
                VStack(alignment: .leading){
                    Text(category.name)
                        .font(.headline)
                    ForEach(category.items){ items in
                        NavigationLink(destination: DetailView(item: items)){
                            Text(items.name)
                        }
                }
                }
            }
            .navigationBarTitle("Nested Lists")
        }
    }
}
struct DetailView: View {
    var item: Item
    
    var body: some View {
        Text("Details for \(item.name)")
            .navigationBarTitle(item.name, displayMode: .inline)
    }
}

//struct ListView: View {
//    var section: Int
//    var body: some View {
//        ForEach(0..<3, id: \.self) { item in // Inner List
//            NavigationLink(destination: DetailView(detailText: "Item \(item) in Section \(section)")) {
//                Text("Item \(item)")
//            }
//        }
//    }
//}
//
//struct DetailView: View {
//    var detailText: String
//    
//    var body: some View {
//        Text(detailText)
//            .navigationBarTitle("Detail", displayMode: .inline)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}

struct Category: Identifiable {
    let id: Int
    let name: String
    let items: [Item]
}

struct Item: Identifiable {
    let id: Int
    let name: String
}
