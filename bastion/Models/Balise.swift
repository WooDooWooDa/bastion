
import Foundation
import UIKit

struct Balise: Codable {
    let balise_id: Int
    let balise_name: String
    let description: String
    let battery_level: String
    let points_green: Int
    let points_tan: Int
    let current_team: String
}

struct BaliseDataCreate: Codable {
    var id: String
    var field_id: String
}

func randomName() -> String {
    return ["Église", "Maison", "Prison", "École"].randomElement()!
}

func randomLocation() -> String {
    return ["Proche de la rivière", "dans la prison", "Sur le camion", "dans la salle de droite"].randomElement()!
}
