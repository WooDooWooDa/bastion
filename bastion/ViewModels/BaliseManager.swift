
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
    
    func updateBaliseToServer(balise: baliseObservable) {
        print(balise.balise_name)
        ApiService.shared.updateBalise(baliseManager: self, balise: balise)
        sleep(1)
        updateBalisesFromServer()
    }
    
    func updateBalisesFromServer() {
        ApiService.shared.getBalises(baliseManager: self)
    }
    
}
