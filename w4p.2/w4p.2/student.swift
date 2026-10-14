import Foundation

struct Student: Identifiable {
    var id: Int
    var name: String
    var subjects: [StudentSubject] = []

    var gpa: Double {
        let marks = subjects.compactMap { $0.mark }
        guard !marks.isEmpty else { return 0 }

        return marks.reduce(0, +) / Double(marks.count)
    }
}

