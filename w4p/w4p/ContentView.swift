
import SwiftUI

class Fish {
    private var id: Int
    private var name: String
    private var color: String
    private var price: Double

    init(id: Int, name: String, color: String, price: Double) {
        self.id = id
        self.name = name
        self.color = color
        self.price = price
    }

    func getInfo() -> String {
        return "[\(id)] \(name) - \(color) - $\(price)"
    }

    func setName(newName: String) {
        self.name = newName
    }
}


struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Fish Information")
                .font(.title)

            Text("[1] Neon Fish - Red - $20000.0")

            Text("[1] Betta Fish - Red - $20000.0")
        }
        .padding()
        .onAppear {
            let fish1 = Fish(
                id: 1,
                name: "Neon Fish",
                color: "Red",
                price: 20000
            )

            print(fish1.getInfo())

            fish1.setName(newName: "Betta Fish")

            print(fish1.getInfo())
        }
    }
}
