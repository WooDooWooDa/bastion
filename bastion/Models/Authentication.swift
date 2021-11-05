
import Foundation
import SwiftUI

class Authentication: ObservableObject {
    @Published var employee: Employee!
    @Published var isValidated = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case invalidTest
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Votre username ou votre mot de passe est incorrect. Essayez de nouveau...", comment: "")
            case .invalidTest:
                return ""
            }
        }
    }
    
    func updateValidation(success: Bool) {
        if (success) {
            isValidated = true
        }
    }
}
