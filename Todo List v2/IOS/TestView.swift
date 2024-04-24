import SwiftUI

// Define a class for the todo item
class TodoItem: Identifiable {
    var id = UUID()
    var task: String
    var completed: Bool = false
    
    init(task: String) {
        self.task = task
    }
}

// Define a class for the linked list node
class ListNode<T> {
    var value: T
    var next: ListNode<T>?

    init(value: T) {
        self.value = value
    }
}

// Define the linked list struct
struct LinkedList<T> {
    var head: ListNode<T>?

    // Function to insert a new node at the end of the linked list
    mutating func append(_ value: T) {
        let newNode = ListNode(value: value)
        if head == nil {
            head = newNode
        } else {
            var current = head
            while current?.next != nil {
                current = current?.next
            }
            current?.next = newNode
        }
    }

    // Function to convert the linked list into an array for SwiftUI
    func toArray() -> [T] {
        var result = [T]()
        var current = head
        while current != nil {
            result.append(current!.value)
            current = current?.next
        }
        return result
    }
}

// SwiftUI view to display the todo list
struct TodoListView: View {
    var todoItems: [TodoItem]
    var toggleCompletion: (TodoItem) -> Void

    var body: some View {
        List(todoItems) { todoItem in
            Button(action: {
                toggleCompletion(todoItem)
            }) {
                HStack {
                    Text(todoItem.task)
                    Spacer()
                    if todoItem.completed {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

// SwiftUI view to manage the todo list
struct TodoListViewManager: View {
    @State var todoList = LinkedList<TodoItem>()

    var body: some View {
        VStack {
            TextField("Add Task", text: $newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Task") {
                addTask()
            }
            
            TodoListView(todoItems: todoList.toArray()) { todoItem in
                toggleCompletion(todoItem)
            }
        }
        .padding()
    }
    
    @State private var newTask: String = ""
    
    private func addTask() {
        if !newTask.isEmpty {
            todoList.append(TodoItem(task: newTask))
            newTask = ""
        }
    }
    
    private func toggleCompletion(_ todoItem: TodoItem) {
        if let node = findNode(for: todoItem) {
            node.value.completed.toggle()
        }
    }
    
    private func findNode(for todoItem: TodoItem) -> ListNode<TodoItem>? {
        var current = todoList.head
        while current != nil {
            if current?.value.id == todoItem.id {
                return current
            }
            current = current?.next
        }
        return nil
    }
}

// Example usage
struct ContentView_1: View {
    var body: some View {
        TodoListViewManager()
    }
}
#Preview(body: {
    TodoListViewManager()
})
