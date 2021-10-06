
import Foundation
import UIKit

struct Balise: Identifiable {
    let id = UUID()
    let name: String
    let batteryLevel: Float
    let points: Int
    let currentTeam: String
}

class Baliselist: ObservableObject {
    static let testList = [
        Balise(
            name: "Eglise",
            batteryLevel: 100,
            points: 10,
            currentTeam: "Green"
        ),
        Balise(
            name: "Prison",
            batteryLevel: 100,
            points: 10,
            currentTeam: "Tan"
        ),
        Balise(
            name: "Bateau",
            batteryLevel: 99,
            points: 21,
            currentTeam: "Tan"
        ),
        Balise(
            name: "Magasin",
            batteryLevel: 98,
            points: 14,
            currentTeam: "Tan"
        ),
        Balise(
            name: "Avion",
            batteryLevel: 100,
            points: 40,
            currentTeam: "Green"
        )
    ]
}
