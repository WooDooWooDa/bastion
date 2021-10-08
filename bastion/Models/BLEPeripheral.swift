
import Foundation
import CoreBluetooth

struct BLEPeripheral: Identifiable {
    let id: Int
    let name: String
    let rssi: Int
}
