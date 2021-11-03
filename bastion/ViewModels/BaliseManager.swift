
import Foundation
import SwiftUI

class BaliseManager: ObservableObject {
    @Published var balises = [Balise]()
    @State var wrongBalise = false
    
    init() {
        let returnedBalises = ApiService.shared.getBalises(enterpriseId: 1)
        for balise in returnedBalises {
            self.balises.append(balise)
        }
    }
    
    func addBalise(id: String) {
        if balises.contains(where: {$0.id == id}) {
            wrongBalise = true
            print("error")
            return
        }
        self.balises.append(Balise(id: id))
    }
    
    func getBalises() -> [Balise] {
        return balises
    }
}
