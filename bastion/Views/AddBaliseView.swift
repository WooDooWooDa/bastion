
import SwiftUI

struct AddBaliseView: View {
    @ObservedObject var bleManager = BLEManager()
    
    @EnvironmentObject var baliseManager: BaliseManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("connections aux balises")
                .bold()
                .font(Font.system(size: 30).smallCaps())
            List {
                ForEach(bleManager.peripherals) { peripheral in
                    HStack {
                        Text(peripheral.name)
                        Spacer()
                        Text(String(peripheral.rssi))
                        Button(action: {
                            bleManager.connect(peripheral: peripheral, baliseManager: baliseManager, presentationMode: presentationMode)
                        }) {
                            Text("Connecter")
                        }
                        .padding()
                    }
                }
                HStack {
                    if (bleManager.isScanning) {
                        Text("Scan en cours...   ")
                            .opacity(0.6)
                        ProgressView()
                    }
                }
                .listRowInsets(EdgeInsets())
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(UIColor.systemGroupedBackground))
            }.frame(height: 500)
            HStack {
                VStack {
                    Button(action: {
                        bleManager.startScanning()
                    }) {
                        Text("Commencer le scan de balise...")
                    }
                    .padding()
                }
            }
        }
    }
}

struct AddBaliseView_Preview: PreviewProvider {
    static var previews: some View {
        AddBaliseView()
    }
}
