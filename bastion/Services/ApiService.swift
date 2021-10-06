
import Foundation

class ApiService {
    static let shared = ApiService()
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool,Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if (credentials.password == "password") {
                completion(.success(true))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
}
