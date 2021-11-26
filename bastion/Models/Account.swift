
import Foundation

struct Account: Codable {
    var account_id: Int
    var firstname: String = ""
    var lastname: String = ""
    var enterprise_id: Int
    var xToken: String
    var name: String
    var address: String
}
