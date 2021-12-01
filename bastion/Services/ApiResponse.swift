
import Foundation

struct AuthentificationResponse: Codable {
    var data: [Account]
}

struct BaliseResponse: Codable {
    var data: [Balise]
}

struct ApiDataResponse: Decodable {
    var object: String
    var Count: Int
    var nextPage: String
    var data: String
}

struct ApiMessageResponse: Codable, Error {
    var object: String
    var message: String
}
