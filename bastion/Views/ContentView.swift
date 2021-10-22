import SwiftUI

struct TabNavigation: View {
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        TabView {
            BaliseView()
                .tabItem { Label("Balises", systemImage: "antenna.radiowaves.left.and.right") }
            GameView()
                .tabItem{ Label("Parties", systemImage: "gamecontroller") }
        }
        .background(Color.white)
    }
}

struct ItemRow: View {
    var balise: Balise
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .shadow(color: Color.black, radius: 3, x: 4, y: 2)
            HStack {
                VStack {
                    Image(systemName: "antenna.radiowaves.left.and.right.circle")
                        .font(.system(size: 50.0))
                    Text(balise.name)
                        .fontWeight(.bold)
                        .font(Font.system(.title3).smallCaps())
                        .padding(.horizontal, 15)
                }
                .foregroundColor(Color.init("TextColor"))
                .frame(width: 120)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Possedé par : " + balise.currentTeam)
                    Text("Points : " + String(balise.points))
                    Text("Batterie : " + String(balise.batteryLevel) + "%")
                        .font(.caption)
                }
                .foregroundColor(Color.init("TextColor"))
                .frame(width: 180, height: 85)
            }
            .padding(.vertical, 10)
        }
    }
}

struct BaliseView_Preview: PreviewProvider {
    static var previews: some View {
        BaliseView()
            .previewDevice("iphone X")
            .previewDisplayName("iphone X")
    }
}
