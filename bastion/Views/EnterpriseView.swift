import SwiftUI

struct EnterpriseView: View {
    @EnvironmentObject var authentication: Authentication
    @State var enterprise: Enterprise = Enterprise(name: "loading...")
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("mon entreprise")
                    .bold()
                    .font(Font.system(size: 45).smallCaps())
                NavigationView {
                    ZStack(alignment: .topLeading) {
                        VStack {
                            Image(systemName: "house.circle.fill")
                                .font(.system(size: 100.0))
                                .padding(.vertical, 10)
                            Text(authentication.account.name)
                                .fontWeight(.bold)
                                .font(Font.system(.title).smallCaps())
                            Text(authentication.account.address)
                                .padding(.top, 1)
                            Spacer()
                            Text("Employé connecté")
                                .bold()
                                .font(Font.system(size: 35).smallCaps())
                            Text(authentication.account.firstname + " " + authentication.account.lastname)
                                .padding(.top, 1)
                            Spacer()
                        }.padding()
                    }
                }
            }
        }.onAppear(perform: setEnterprise)
    }
    
    private func setEnterprise() {
        
    }
}

struct EnterpriseView_Preview: PreviewProvider {
    static var previews: some View {
        EnterpriseView()
            .previewDevice("iphone X")
            .previewDisplayName("iphone X")
    }
}
