
import Foundation
import SwiftUI

class UserManager: UIViewController, ObservableObject {
 
    func verifyAll(username: String, password: String) -> Bool {
        if (username == "" || password == "") {
            return false;
        }
        return true
    }
}
