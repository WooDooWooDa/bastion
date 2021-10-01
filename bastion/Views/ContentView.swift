
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("contentView")
    }
}

struct TabNavigation: View {
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        TabView {
            ContentView()
                .tabItem { Label("Content", systemImage: "person")
                .padding() }
            Text("AnotherTab")
                .tabItem{ Label("other", systemImage: "house") }
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iphone 12")
            .previewDisplayName("iphone 12")
    }
}
