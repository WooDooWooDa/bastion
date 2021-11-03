import SwiftUI

struct EnterpriseView: View {
    @EnvironmentObject var authentication: Authentication
    
    @State var enterprise: Enterprise = Enterprise(name: "default")
    //init() {
    //    authentication.setEnterprise(newEnterprise: Enterprise())
    //}
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                Text("mon entreprise")
                    .bold()
                    .font(Font.system(size: 45).smallCaps())
                NavigationView {
                    Text(self.enterprise.name)
                }
            }
        }.onAppear(perform: setEnterprise)
    }
    
    private func setEnterprise() {
        authentication.setEnterprise(newEnterprise: Enterprise(name: "name"))
        enterprise = authentication.enterprise
    }
}

struct EnterpriseView_Preview: PreviewProvider {
    static var previews: some View {
        EnterpriseView()
            .previewDevice("iphone X")
            .previewDisplayName("iphone X")
    }
}
