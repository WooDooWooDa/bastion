
import Foundation
import UIKit

class baliseObservable: ObservableObject {
    var balise_id: Int = 0
    var balise_name: String = ""
    var description: String = ""
    var battery_level: String = ""
    var points_green: String = ""
    var points_tan: String = ""
    var current_team: String = ""
}

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

struct BaliseDataUpdate: Codable {
    var pointsGreen: Int
    var pointsTan: Int
    var currentTeam: String
    var name: String
    var description: String
}

enum Team: String, CaseIterable {
    case NA
    case Green
    case Tan
}
