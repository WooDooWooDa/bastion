
import Foundation
import SwiftUI

class BaliseManager: ObservableObject {
    @Published var balises = [Balise]()
    @State var wrongBalise = false
    @Published var currentAccount: Account?

    func getBalises() -> [Balise] {
        return balises
    }
    
    func setAccount(account: Account) {
        currentAccount = account
        updateBalisesFromServer()
    }
    
    func addBalise(id: String) {
        ApiService.shared.addBalise(baliseManager: self, baliseId: id)
    }
    
    func updateBaliseToServer(balise: Balise) {
        print("UPDATING BALISE..." + balise.balise_name)
    }
    
    func updateBalisesFromServer() {
        ApiService.shared.getBalises(baliseManager: self)
    }
    
}
