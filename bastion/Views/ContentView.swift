import SwiftUI

struct BaliseView: View {
    var balises: [Balise] = Baliselist.testList
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("mes balises")
                    .foregroundColor(.black).bold()
                    .font(Font.system(size: 45).smallCaps())
                NavigationView {
                    List {
                        ForEach(balises, id: \.id) { balise in
                            NavigationLink(destination: BaliseDetailView(balise: balise), label: { ItemRow(balise: balise) }
                            )
                        }
                        .padding(.vertical, 3)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .navigationBarTitle("Retour à mes balises")
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

struct TabNavigation: View {
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        TabView {
            BaliseView()
                .tabItem { Label("Balises", systemImage: "antenna.radiowaves.left.and.right")
                .padding() }
            Text("AnotherTab")
                .tabItem{ Label("other", systemImage: "house") }
        }
        .background(Color.white)
    }
}

struct ItemRow: View {
    var balise: Balise
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
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
                .frame(width: 140)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Possedé par : " + balise.currentTeam)
                    Text("Points : " + String(balise.points))
                    Text("Batterie : " + String(balise.batteryLevel) + "%")
                        .font(.caption)
                }
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
