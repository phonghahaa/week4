import Foundation

struct StudentSubject: Identifiable {
    var id: String {
        "\(idStudent)-\(idSubject)"
    }

    var idStudent: Int
    var idSubject: Int
    var mark: Double? = nil
}
