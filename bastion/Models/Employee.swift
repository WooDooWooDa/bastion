
import Foundation

struct Employee: Codable, Identifiable {
    var id: Int
    var username: String = ""
    var password: String = ""
    var enterpriseId: Int = 0
    var firstname: String = ""
    var lastname: String = ""
}
