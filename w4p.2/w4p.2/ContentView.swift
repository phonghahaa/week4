import SwiftUI

struct ContentView: View {
    @StateObject private var school = SchoolManagement()

    @State private var studentName = ""
    @State private var subjectName = ""
    @State private var selectedStudentID = 0
    @State private var selectedSubjectID = 0
    @State private var mark = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Add Student") {
                    TextField("Student name", text: $studentName)

                    Button("Add Student") {
                        guard !studentName.isEmpty else { return }
                        school.addStudent(name: studentName)
                        studentName = ""
                    }
                }

                Section("Add Subject") {
                    TextField("Subject name", text: $subjectName)

                    Button("Add Subject") {
                        guard !subjectName.isEmpty else { return }
                        school.addSubject(name: subjectName)
                        subjectName = ""
                    }
                }

                Section("Register Subject") {
                    Picker("Student", selection: $selectedStudentID) {
                        Text("Select Student").tag(0)

                        ForEach(school.students) { student in
                            Text(student.name).tag(student.id)
                        }
                    }

                    Picker("Subject", selection: $selectedSubjectID) {
                        Text("Select Subject").tag(0)

                        ForEach(school.subjects) { subject in
                            Text(subject.name).tag(subject.id)
                        }
                    }

                    Button("Register") {
                        school.registerSubject(
                            studentID: selectedStudentID,
                            subjectID: selectedSubjectID
                        )
                    }
                    .disabled(
                        selectedStudentID == 0 ||
                        selectedSubjectID == 0
                    )
                }

                Section("Update Mark") {
                    TextField("Mark (0-10)", text: $mark)
                        .keyboardType(.decimalPad)

                    Button("Update Mark") {
                        guard let value = Double(
                            mark.replacingOccurrences(of: ",", with: ".")
                        ) else {
                            return
                        }

                        school.updateMark(
                            studentID: selectedStudentID,
                            subjectID: selectedSubjectID,
                            mark: value
                        )

                        mark = ""
                    }
                    .disabled(
                        selectedStudentID == 0 ||
                        selectedSubjectID == 0
                    )
                }

                Section("Students") {
                    ForEach(school.students) { student in
                        VStack(alignment: .leading) {
                            Text(student.name)
                                .font(.headline)

                            Text(
                                "GPA: \(student.gpa, specifier: "%.2f")"
                            )

                            ForEach(student.subjects) { ss in
                                HStack {
                                    Text(
                                        school.subjects.first {
                                            $0.id == ss.idSubject
                                        }?.name ?? "Unknown"
                                    )

                                    Spacer()

                                    Text(
                                        ss.mark.map {
                                            String(format: "%.1f", $0)
                                        } ?? "Not graded"
                                    )
                                }
                            }
                        }
                    }
                }

                Section("Students with GPA above 8") {
                    ForEach(school.studentsGPAAbove8) { student in
                        Text(
                            "\(student.name) - \(student.gpa, specifier: "%.2f")"
                        )
                    }

                    if school.studentsGPAAbove8.isEmpty {
                        Text("No students found")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Failed Students") {
                    Picker(
                        "Subject",
                        selection: $selectedSubjectID
                    ) {
                        Text("Select Subject").tag(0)

                        ForEach(school.subjects) { subject in
                            Text(subject.name).tag(subject.id)
                        }
                    }

                    ForEach(
                        school.failedStudents(
                            subjectID: selectedSubjectID
                        )
                    ) { student in
                        Text(student.name)
                    }

                    if school.failedStudents(
                        subjectID: selectedSubjectID
                    ).isEmpty {
                        Text("No failed students")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("School Management")
        }
    }
}
