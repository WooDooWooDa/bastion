
import Foundation
import UIKit

struct Balise: Identifiable {
    let id: String
    let name: String = randomName()
    let batteryLevel: Float = 0
    let points: Int = 0
    let currentTeam: String = ""
    let location: String = randomLocation()
}

func randomName() -> String {
    return ["Église", "Maison", "Prison", "École"].randomElement()!
}

func randomLocation() -> String {
    return ["Proche de la rivière", "dans la prison", "Sur le camion", "dans la salle de droite"].randomElement()!
}
