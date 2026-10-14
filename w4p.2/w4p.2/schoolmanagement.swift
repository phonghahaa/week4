import Foundation
import Combine

class SchoolManagement: ObservableObject {
    @Published var students: [Student] = []
    @Published var teachers: [Teacher] = []
    @Published var subjects: [Subject] = []

    func addStudent(name: String) {
        let id = (students.map(\.id).max() ?? 0) + 1
        students.append(Student(id: id, name: name))
    }

    func addSubject(name: String) {
        let id = (subjects.map(\.id).max() ?? 0) + 1
        subjects.append(Subject(id: id, name: name))
    }

    func addTeacher(name: String) {
        let id = (teachers.map(\.id).max() ?? 0) + 1
        teachers.append(Teacher(id: id, name: name))
    }

    func assignSubjectToTeacher(
        teacherID: Int,
        subjectID: Int
    ) {
        guard let subject = subjects.first(where: {
            $0.id == subjectID
        }),
        let index = teachers.firstIndex(where: {
            $0.id == teacherID
        }) else {
            return
        }

        if !teachers[index].subjects.contains(where: {
            $0.id == subjectID
        }) {
            teachers[index].subjects.append(subject)
        }
    }

    func registerSubject(
        studentID: Int,
        subjectID: Int
    ) {
        guard subjects.contains(where: {
            $0.id == subjectID
        }),
        let index = students.firstIndex(where: {
            $0.id == studentID
        }) else {
            return
        }

        guard !students[index].subjects.contains(where: {
            $0.idSubject == subjectID
        }) else {
            return
        }

        students[index].subjects.append(
            StudentSubject(
                idStudent: studentID,
                idSubject: subjectID
            )
        )
    }

    func updateMark(
        studentID: Int,
        subjectID: Int,
        mark: Double
    ) {
        guard (0...10).contains(mark),
              let studentIndex = students.firstIndex(where: {
                  $0.id == studentID
              }),
              let subjectIndex = students[studentIndex].subjects.firstIndex(where: {
                  $0.idSubject == subjectID
              }) else {
            return
        }

        students[studentIndex].subjects[subjectIndex].mark = mark
    }

    var studentsGPAAbove8: [Student] {
        students.filter {
            !$0.subjects.isEmpty &&
            $0.subjects.allSatisfy { $0.mark != nil } &&
            $0.gpa > 8
        }
    }

    func failedStudents(subjectID: Int) -> [Student] {
        students.filter { student in
            student.subjects.contains {
                $0.idSubject == subjectID &&
                ($0.mark ?? 10) < 4 &&
                $0.mark != nil
            }
        }
    }
}

