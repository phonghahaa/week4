import Foundation

struct Teacher: Identifiable {
    var id: Int
    var name: String
    var subjects: [Subject] = []
}

