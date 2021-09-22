import SwiftUI

let colorGradient = LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct LoginView: View {
    let lightGrayColor = Color(red: 239, green: 243, blue: 244, opacity: 1)
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Image("LoginBg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Image("LoginCard")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 360, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70, alignment: .top)
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius:5).fill(lightGrayColor))
                SecureField("Mot de passe", text: $password)
                    .padding()
                    .foregroundColor(.black)
                    .background(RoundedRectangle(cornerRadius:5).fill(lightGrayColor))
                Button( action: {
                    
                }) {
                    LoginButtonContent()
                }
            }
            .frame(width: 230, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        
    }
}

struct LoginButtonContent: View {
    var body: some View {
        return Text("Se connecter")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice(PreviewDevice(rawValue: "iphone 12"))
            .previewDisplayName("iphone 12")
    }
}
