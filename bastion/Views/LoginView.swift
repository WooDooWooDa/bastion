import SwiftUI

let colorGradient = LinearGradient(gradient: Gradient(colors: [Color("LogoTopColor"), Color("LogoBottomColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct LoginView: View {
    
    @State var isLogged: Bool = false
    
    var body: some View {
        if (isLogged) {
            //home
        } else {
            LoginScreen()
        }
        
    }
}

struct LoginScreen: View {
    @State var username: String = ""
    @State var password: String = ""
    @ObservedObject var usermanager = UserManager()
    var body: some View {
        ZStack {
            LoginBackground()
            LoginCard()
            VStack {
                Logo()
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                    TextField("Username", text: $username)
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                }
                .padding()
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Mot de passe", text: $password)
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                }
                .padding()
                Button( action: {
                    usermanager.verifyAll(username: username, password: password)
                }) {
                    LoginButtonContent()
                }
            }
            .frame(width: 330, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("Se connecter")
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 175, height: 40)
            .background(colorGradient)
            .cornerRadius(15)
    }
}

struct WelcomeMsg: View {
    var body: some View {
        Text("Bienvenue !")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct LoginCard: View {
    var body: some View {
        Image("LoginCard")
            .resizable()
            .scaledToFill()
            .frame(width: 390, height: 460, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct LoginBackground: View {
    var body: some View {
        Image("LoginBg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

struct Logo: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .frame(width: 120, height: 120, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iphone 12"))
            .previewDisplayName("iphone 12")
    }
}
