
import Foundation
import CoreBluetooth

struct BLEPeripheral: Identifiable {
    let id: Int
    let identifier: UUID
    let name: String
    let rssi: Int
}
