
import SwiftUI

struct BaliseDetailView: View {
    @EnvironmentObject var baliseManager: BaliseManager
    var balise: Balise
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Image(systemName: "antenna.radiowaves.left.and.right.circle")
                    .font(.system(size: 100.0))
                    .padding(.vertical, 10)
                Text(balise.balise_name)
                    .fontWeight(.bold)
                    .font(Font.system(.title).smallCaps())
                Text(balise.description)
                    .padding(.top, 1)
                Spacer()
                Button(action: {
                    baliseManager.updateBaliseToServer(balise: balise)
                }) {
                    Text("Update la balise")
                }
            }.padding()
            
        }
    }
}
