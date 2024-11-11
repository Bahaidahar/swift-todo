import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var task: String
    var isCompleted: Bool = false
}

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var newTask: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        TextField("Enter new task", text: $newTask)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                            .padding(.leading, 10)
                        
                        Button(action: {
                            if !newTask.isEmpty {
                                let todo = TodoItem(task: newTask)
                                todos.append(todo)
                                newTask = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(15)
                                .background(Circle().fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.top, 20)
                    
                    List {
                        ForEach($todos) { $todo in
                            HStack {
                                Toggle(isOn: $todo.isCompleted) {
                                    Text(todo.task)
                                        .font(.body)
                                        .fontWeight(todo.isCompleted ? .light : .medium)
                                        .strikethrough(todo.isCompleted, color: .gray)
                                        .foregroundColor(todo.isCompleted ? .black : .black)  // Set text color to black
                                }
                                .toggleStyle(SwitchToggleStyle(tint: Color.purple))
                            }
                            .padding(10)
                            .background(todo.isCompleted ? Color.gray.opacity(0.2) : Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.1), radius: 5, x: 2, y: 2)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(PlainListStyle())
                    .padding(.top, 10)
                    
                    Spacer()
                }
            }
            .navigationTitle("To-Do List")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.purple)
    }
}


