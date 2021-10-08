
import Foundation

class BaliseManager: ObservableObject {
    @Published var balises = [Balise]()
    
    func addBalise(newBalise: Balise) {
        self.balises.append(newBalise)
    }
    
    func getBalises() -> [Balise] {
        return balises
    }
}
