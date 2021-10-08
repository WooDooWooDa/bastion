
import Foundation
import CoreBluetooth
import SwiftUI

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    var myCentral: CBCentralManager!
    @Published var isSwitchedOn = false
    @Published var isScanning = false
    @Published var peripherals = [BLEPeripheral]()
    private var allCBPeripherals = [CBPeripheral]()
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func connect(peripheral: BLEPeripheral, baliseManager: BaliseManager) {
        isScanning = false
        allCBPeripherals.forEach { p in
            if (p.name == peripheral.name) {
                myCentral.connect(p, options: nil)
                baliseManager.addBalise(newBalise: Balise(name: peripheral.name, batteryLevel: 100, points: 0, currentTeam: "Green"))
            }
        }
    }
    
    func startScanning() {
        isScanning = true
        print("Starting Scanning")
        myCentral.scanForPeripherals(withServices: nil, options: nil) //specify service in esp32
    }
    
    func stopScanning() {
        isScanning = false
        print("Stoping Scanning")
        myCentral.stopScan()
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var peripheralName: String!
        
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = name
            let newPeripheral = BLEPeripheral(id: peripherals.count, name: peripheralName, rssi: RSSI.intValue)
            peripherals.append(newPeripheral)
            allCBPeripherals.append(peripheral)
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        } else {
            isSwitchedOn = false
        }
    }
}
