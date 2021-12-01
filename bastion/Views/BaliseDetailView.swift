
import SwiftUI

struct BaliseDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var baliseManager: BaliseManager
    var balise: Balise
    @State var modifyActivate = false
    @State var isLoading = false
    @StateObject var baliseInput = baliseObservable()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                if !modifyActivate {
                    Image(systemName: "antenna.radiowaves.left.and.right.circle")
                        .font(.system(size: 100.0))
                        .padding(.vertical, 10)
                    Text(balise.balise_name)
                        .fontWeight(.bold)
                        .font(Font.system(.title).smallCaps())
                    Text(balise.description)
                        .padding(.top, 1)
                    Button(action: {
                        modifyActivate = true
                    }) {
                        Text("Changer les informations de la balise")
                    }.padding()
                    Spacer()
                } else {
                    VStack {
                        Form {
                            Section(header: Text("Informations")) {
                                TextField("Nom", text: $baliseInput.balise_name)
                                TextField("description", text: $baliseInput.description)
                            }
                            Section(header: Text("Pointages")) {
                                Picker("Équipe", selection: $baliseInput.current_team) {
                                    Text("NA").tag(Team.NA)
                                    Text("Green").tag(Team.Green)
                                    Text("Tan").tag(Team.Tan)
                                }
                                TextField("Points Green", text: $baliseInput.points_green)
                                    .keyboardType(.numberPad)
                                TextField("Points Tan", text: $baliseInput.points_tan)
                                    .keyboardType(.numberPad)
                            }
                        }.navigationTitle("Modifier la balise")
                        Button(action: {
                            isLoading = true
                            baliseManager.updateBaliseToServer(balise: baliseInput)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Confirmer les changements")
                        }.padding()
                    }
                }
            }.padding()
        }.onAppear(perform: populateForm)
    }
    
    func populateForm() {
        baliseInput.balise_id = balise.balise_id
        baliseInput.battery_level = balise.battery_level
        baliseInput.balise_name = balise.balise_name
        baliseInput.description = balise.description
        baliseInput.current_team = balise.current_team
        baliseInput.points_green = (String)(balise.points_green)
        baliseInput.points_tan = (String)(balise.points_tan)
    }
}
