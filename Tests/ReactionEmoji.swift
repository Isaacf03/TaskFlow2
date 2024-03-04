import SwiftUI

struct YourNewViewName: View { // Change ContentView to your desired new name
    // Define a state variable to track if the menu is showing
    @State private var isMenuShowing = false
    
    var body: some View {
        VStack {
            // Button with long press gesture recognizer
            Button(action: {
                // Action when the button is tapped
                // This can be empty as we'll handle long press separately
            }) {
                Text("Press and Hold")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .onLongPressGesture {
                // Action when the button is long-pressed
                // Toggle the state variable to show/hide the menu
                isMenuShowing.toggle()
            }
        }
        .contextMenu(){
            // Menu items
            Button(action: {
                // Action for option 1: Add Category
                // Implement your logic here
            }) {
                Text("Add Category")
                Image(systemName: "folder.badge.plus")
            }
            Button(action: {
                // Action for option 2: Add New Task
                // Implement your logic here
            }) {
                Text("Add New Task")
                Image(systemName: "plus.square.on.square")
            }
            Button(action: {
                // Action for option 3: Add Task
                // Implement your logic here
            }) {
                Text("Add Task")
                Image(systemName: "plus.circle")
            }
        }
    }
}

struct YourNewViewName_Previews: PreviewProvider {
    static var previews: some View {
        YourNewViewName() // Change ContentView() to your new view name
    }
}
