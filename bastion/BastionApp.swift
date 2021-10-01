import SwiftUI

@main
struct BastionApp: App {
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            if (authentication.isValidated) {
                TabNavigation()
                    .environmentObject(authentication)
            } else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}
