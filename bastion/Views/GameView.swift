import SwiftUI

struct GameView: View {
    @EnvironmentObject var authentication: Authentication
    @StateObject private var gameManager = GameManager()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("Partie")
                    .bold()
                    .font(Font.system(size: 45).smallCaps())
                if !gameManager.gameIsActive {
                    Button(action: {
                        gameManager.startGame()
                    }) {
                        Text("Commencer une partie!")
                    }
                } else {
                    Button(action: {
                        gameManager.stopGame()
                    }) {
                        Text("Arrêter la partie en cours")
                    }
                }
                Spacer()
            }
        }.onAppear(perform: setAccount)
    }
    
    func setAccount() {
        gameManager.setAccount(account: authentication.account)
    }
}
