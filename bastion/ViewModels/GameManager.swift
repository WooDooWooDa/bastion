
import Foundation
import SwiftUI

class GameManager: ObservableObject {
    @Published var currentAccount: Account?
    @Published var gameIsActive = false
    var activeGameId = 0

    func setAccount(account: Account) {
        currentAccount = account
    }
    
    func startGame() {
        ApiService.shared.startGame(gameManager: self, fieldId: 1)
    }
    
    func stopGame() {
        ApiService.shared.stopGame(gameManager: self, gameId: activeGameId)
        activeGameId = 0
        gameIsActive = false
    }
    
    func getGame() {
        gameIsActive = false
    }
}
