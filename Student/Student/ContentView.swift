
import SwiftUI

struct ContentView: View {
    @State private var students: [Student] = [
        Student(id: 1, name: "khoi Student", gpa: 9, age: 20),
        Student(id: 2, name: "tam Student", gpa: 9, age: 35),
        Student(id: 3, name: "phong Student", gpa: 9, age: 25),
        Student(id: 4, name: "hau student", gpa: 9, age: 40)
    ]

    var body: some View {
        NavigationView {
            List(students) { student in
                HStack(spacing: 16) {
                    Image(systemName: "student.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading) {
                        Text(student.getName())
                            .font(.headline)

                        Text("\(student.getGpa())_ - \(student.getAge())")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("My class")
        }
    }
}

#Preview {
    ContentView()
}

