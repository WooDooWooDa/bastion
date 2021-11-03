
import Foundation

class ApiService {
    static let shared = ApiService()
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        guard let encodedCredentials = try? JSONEncoder().encode(credentials) else {
            print("Failed to encode credentials")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/register")!    //"https://bastion-api.com/account/authenticate"
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content/Type")
        request.httpMethod = "POST"
        request.httpBody = encodedCredentials
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //handle result here
            print()
            
            guard let data = data else {
                print("No data received from api")
                return
            }
            
            print("DATA : " + String(data: data, encoding: String.Encoding.utf8)!)
            
            if let decodedData = try? JSONDecoder().decode(ApiDataResponse.self, from: data) {
                print(decodedData)
                completion(.success(true))
                //read data
                //if data object is error return completion(.failure(Authentication.invalidCredentials))
            } else {
                print("Invalid reponse from api")
                completion(.failure(.invalidCredentials))
            }
        }.resume()
    }
    
    func getBalises(enterpriseId: Int) -> Array<Balise> {
        return [Balise(id: "101")]
    }
}
