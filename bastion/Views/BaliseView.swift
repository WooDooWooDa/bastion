import SwiftUI

struct BaliseView: View {
    @State var openSheet = false
    @EnvironmentObject var authentication: Authentication
    @StateObject private var baliseManager = BaliseManager()
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("mes balises")
                    .bold()
                    .font(Font.system(size: 45).smallCaps())
                NavigationView {
                    List {
                        ForEach(baliseManager.getBalises(), id: \.balise_id) { balise in
                            NavigationLink(destination: BaliseDetailView(balise: balise), label: { ItemRow(balise: balise) })
                        }
                        .padding(.vertical, 3)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        HStack {
                            Button(action: {
                                openSheet.toggle()
                            }) {
                                Text("Connecter une balise ...")
                            }.sheet(isPresented: $openSheet) {
                                AddBaliseView()
                                    .environmentObject(baliseManager)
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(UIColor.systemGroupedBackground))
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Retour à mes balises")
                    .navigationBarHidden(true)
                }.environmentObject(baliseManager)
            }
        }.onAppear(perform: getBalises)
         .onReceive(timer) { time in
             baliseManager.updateBalisesFromServer()
        }
    }
    
    private func getBalises() {
        baliseManager.setAccount(account: authentication.account)
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
                    Text(balise.balise_name)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .font(Font.system(.title3).smallCaps())
                        .padding(.horizontal, 15)
                }
                .foregroundColor(Color.init("TextColor"))
                .frame(width: 120)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Équipe : " + balise.current_team)
                    Text("Points Green : " + String(balise.points_green))
                        .font(.body)
                    Text("Points Tan : " + String(balise.points_tan))
                        .font(.body)
                    Text("Batterie : " + String(balise.battery_level) + " Volt")
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
