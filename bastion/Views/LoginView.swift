import SwiftUI

let colorGradient = LinearGradient(gradient: Gradient(colors: [Color("LogoTopColor"), Color("LogoBottomColor")]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct LoginView: View {
    @StateObject private var usermanager = UserManager()
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        ZStack {
            LoginBackground()
            LoginCard()
            VStack {
                Logo()
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                    TextField("Username", text: $usermanager.credentials.username)
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                }
                .padding()
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Mot de passe", text: $usermanager.credentials.password)
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                }
                .padding()
                if (usermanager.showProgressView) {
                    ProgressView()
                }
                Button( action: {
                    usermanager.login {
                        success in authentication.updateValidation(success: success)
                    }
                }) {
                    LoginButtonContent()
                }
                .disabled(usermanager.loginDisabled)
            }
            .autocapitalization(.none)
            .disabled(usermanager.showProgressView)
            .alert(item: $usermanager.error) {
                error in Alert(title: Text("Connexion Invalide"), message: Text(error.localizedDescription))
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iphone 12")
            .previewDisplayName("iphone 12")
        LoginView()
            .previewDevice("iphone X")
            .previewDisplayName("iphone X")
    }
}
