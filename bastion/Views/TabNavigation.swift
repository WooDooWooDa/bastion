import SwiftUI

struct TabNavigation: View {
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        TabView {
            BaliseView()
                .tabItem { Label("Balises", systemImage: "antenna.radiowaves.left.and.right") }
            GameView()
                .tabItem{ Label("Partie", systemImage: "gamecontroller") }
            EnterpriseView()
                .tabItem{ Label("Entreprise", systemImage: "person.2.fill") }
                .environmentObject(authentication)
        }
        .background(Color.white)
    }
}
