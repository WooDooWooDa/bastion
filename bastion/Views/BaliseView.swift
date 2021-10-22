import SwiftUI

struct BaliseView: View {
    @State var openSheet = false
    @StateObject private var baliseManager = BaliseManager()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("mes balises")
                    .bold()
                    .font(Font.system(size: 45).smallCaps())
                NavigationView {
                    List {
                        ForEach(baliseManager.getBalises(), id: \.id) { balise in
                            NavigationLink(destination: BaliseDetailView(balise: balise), label: { ItemRow(balise: balise) }
                            )
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
                }
            }
        }
    }
}
