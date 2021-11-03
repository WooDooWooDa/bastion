
import Foundation

struct ApiDataResponse: Decodable {
    var object: String
    var Count: Int
    var nextPage: String
    var data: String
}

struct ApiErrorResponse: Codable, Error {
    var object: String
    var message: String
}
