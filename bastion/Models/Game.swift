
import Foundation

struct GameDataStart: Codable {
    var fieldId: Int
}

struct GameResponse: Codable {
    var data: GameId
}

struct GameId: Codable {
    var gameId: Int
}
