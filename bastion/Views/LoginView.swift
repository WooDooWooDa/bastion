import SwiftUI

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
                        .foregroundColor(.black)
                    TextField("", text: $usermanager.credentials.username)
                        .disableAutocorrection(true)
                        .foregroundColor(.black)
                        .placeholder(when: usermanager.credentials.username.isEmpty) {
                            Text("Nom d'utilisateur").foregroundColor(.black).opacity(0.7)
                        }
                }
                .padding()
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.black)
                    SecureField("", text: $usermanager.credentials.password)
                        .foregroundColor(.black)
                        .disableAutocorrection(true)
                        .placeholder(when: usermanager.credentials.password.isEmpty) {
                            Text("Mot de passe").foregroundColor(.black).opacity(0.7)
                        }
                }
                .padding()
                if (usermanager.showProgressView) {
                    ProgressView()
                        .padding(.vertical, 10)
                } else {
                    Button( action: {
                        usermanager.login(authentication: authentication) {
                            success in authentication.updateValidation(success: success)
                        }
                    }) {
                        LoginButtonContent()
                    }
                    .padding()
                    .opacity(usermanager.loginDisabled ? 0.5 : 1)
                    .disabled(usermanager.loginDisabled)
                }
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
            .background(LinearGradient(gradient: Gradient(colors: [Color("LogoTopColor"), Color("LogoBottomColor")]), startPoint: .topLeading, endPoint: .bottomTrailing))
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
            .frame(width: 125, height: 125, alignment: .top)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iphone X")
            .previewDisplayName("iphone X")
    }
}
