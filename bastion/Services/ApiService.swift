
import Foundation

class ApiService {
    static let shared = ApiService()
    static let baseUrl: String = "http://206.167.241.211:81"
    
    func login(authentication: Authentication, credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        guard let encodedCredentials = try? JSONEncoder().encode(credentials) else {
            print("Failed to encode credentials")
            return
        }
        
        let url = URL(string: ApiService.baseUrl + "/account/authenticate")!
        let request = createRequest(method: "POST", url: url, body: encodedCredentials)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let _: URLResponse = response, error == nil else {return}
            
            let jsonString = String(data: data, encoding: String.Encoding.utf8)
            
            DispatchQueue.main.async {
                if let decodedData = try? JSONDecoder().decode(AuthentificationResponse.self, from: jsonString!.description.data(using: .utf8)!) {
                    authentication.account = decodedData.data[0]
                    completion(.success(true))
                } else {
                    print("Invalid reponse from api")
                    completion(.failure(.invalidCredentials))
                }
            }
        }.resume()
    }
    
    func getBalises(baliseManager: BaliseManager) {
        let url = URL(string: ApiService.baseUrl + "/balises")!
        var request = createRequest(method: "GET", url: url, body: Data())
        request.setValue(baliseManager.currentAccount?.xToken, forHTTPHeaderField: "X-TOKEN")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let _: URLResponse = response, error == nil else {return}
            
            let jsonString = String(data: data, encoding: String.Encoding.utf8)
            
            DispatchQueue.main.async {
                if let decodedData = try? JSONDecoder().decode(BaliseResponse.self, from: jsonString!.description.data(using: .utf8)!) {
                    baliseManager.balises = decodedData.data
                } else {
                    print("Invalid reponse from api")
                    baliseManager.balises = []
                }
            }
        }.resume()
    }
    
    func addBalise(baliseManager: BaliseManager, baliseId: String) {
        guard let encodedBaliseData = try? JSONEncoder().encode(BaliseDataCreate(id: baliseId, field_id: "1")) else {
            print("Failed to encode balise")
            return
        }
        
        let url = URL(string: ApiService.baseUrl + "/balises/create")!
        var request = createRequest(method: "POST", url: url, body: encodedBaliseData)
        request.setValue(baliseManager.currentAccount?.xToken, forHTTPHeaderField: "X-TOKEN")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, let _: URLResponse = response, error == nil else {return}
        }.resume()
    }
    
    func updateBalise(baliseManager: BaliseManager, balise: baliseObservable) {
        guard let encodedBaliseData = try? JSONEncoder().encode(BaliseDataUpdate(pointsGreen: Int(balise.points_green) ?? 0, pointsTan: Int(balise.points_tan) ?? 0, currentTeam: balise.current_team, name: balise.balise_name, description: balise.description)) else {
            print("Failed to encode balise")
            return
        }
        
        let url = URL(string: ApiService.baseUrl + "/balises/" + (String)(balise.balise_id) + "/update")!
        var request = createRequest(method: "POST", url: url, body: encodedBaliseData)
        request.setValue(baliseManager.currentAccount?.xToken, forHTTPHeaderField: "X-TOKEN")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, let _: URLResponse = response, error == nil else {return}
        }.resume()
    }
    
    func startGame(gameManager: GameManager, fieldId: Int) {
        guard let encodedGame = try? JSONEncoder().encode(GameDataStart(fieldId: fieldId)) else {
            print("Failed to encode balise")
            return
        }
        let url = URL(string: ApiService.baseUrl + "/startGame")!
        var request = createRequest(method: "POST", url: url, body: encodedGame)
        request.setValue(gameManager.currentAccount?.xToken, forHTTPHeaderField: "X-TOKEN")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let _: URLResponse = response, error == nil else {return}
            
            let jsonString = String(data: data, encoding: String.Encoding.utf8)
            
            DispatchQueue.main.async {
                if let decodedData = try? JSONDecoder().decode(GameResponse.self, from: jsonString!.description.data(using: .utf8)!) {
                    gameManager.gameIsActive = true
                    gameManager.activeGameId = decodedData.data.gameId
                } else {
                    print("Invalid reponse from api")
                    gameManager.gameIsActive = false
                    gameManager.activeGameId = 0
                }
            }
        }.resume()
    }
    
    func stopGame(gameManager: GameManager, gameId: Int) {
        gameManager.gameIsActive = false
        //stop game
    }
    
    func getEnterprise(employeCode: Int) -> Enterprise {
        //let url = URL(string: "/enterprise/1")!
        //let request = createRequest(method: "GET", url: url, body: employeeId)
        return Enterprise(name: "random name")
    }
    
    private func createRequest(method: String, url: URL, body: Data) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = body
        return request
    }
}
