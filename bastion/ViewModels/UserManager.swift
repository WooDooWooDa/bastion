
import Foundation

class UserManager: ObservableObject {
 
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    
    var loginDisabled: Bool {
        credentials.username.isEmpty || credentials.password.isEmpty
    }
    
    func login(authentication: Authentication, completion: @escaping (Bool) -> Void) {
        showProgressView = true
        //set employee in the api login fct
        authentication.employee = Employee(id: 1, username: "bob", password: "password", enterpriseId: 1, firstname: "firstname", lastname: "lastname")
        return completion(true)
        
        ApiService.shared.login(authentication: authentication, credentials: credentials) { [unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
                case .success:
                    completion(true)
                case .failure(let authError):
                    error = authError
                    credentials = Credentials()
                    completion(false)
            }
        }
    }
    
    func verifyAll(username: String, password: String) -> Bool {
        if (username == "" || password == "") {
            return false;
        }
        return true
    }
}
