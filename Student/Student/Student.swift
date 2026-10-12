import Foundation

class Student: Identifiable {
    var id: Int
    private var name: String
    private var gpa: Double
    private var age: Int

    init(id: Int, name: String, gpa: Double, age: Int) {
        self.id = id
        self.name = name
        self.gpa = gpa
        self.age = age
    }

    func getName() -> String {
        return name
    }

    func getAge() -> Int {
        return age
    }

    func getGpa() -> Double {
        return gpa
    }

    func setName(_ newName: String) {
        self.name = newName
    }
}
