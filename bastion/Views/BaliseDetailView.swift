
import SwiftUI

struct BaliseDetailView: View {
    var balise: Balise
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Image(systemName: "antenna.radiowaves.left.and.right.circle")
                    .font(.system(size: 100.0))
                    .padding(.vertical, 10)
                Text(balise.name)
                    .fontWeight(.bold)
                    .font(Font.system(.title).smallCaps())
                Text(balise.location)
                    .padding(.top, 1)
                Spacer()
            }.padding()
        }
    }
}

struct BaliseDetailView_Preview: PreviewProvider {
    static var previews: some View {
        BaliseDetailView(balise: Balise(id: "100"))
    }
}
