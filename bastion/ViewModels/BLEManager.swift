
import Foundation
import CoreBluetooth
import SwiftUI

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    var myCentral: CBCentralManager!
    @Published var isSwitchedOn = false
    @Published var isScanning = false
    @Published var peripherals = [BLEPeripheral]()
    
    private var connected: CBPeripheral!
    private var allCBPeripherals = [CBPeripheral]()
    private var baliseService = CBUUID(string: "150F")
    private var baliseIDCaracteristic = CBUUID(string: "151F")
    private var baliseManager: BaliseManager!
    private var presentationMode: Binding<PresentationMode>!
    
    override init() {
        super.init()
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func connect(peripheral: BLEPeripheral, baliseManager: BaliseManager, presentationMode: Binding<PresentationMode>) {
        print("Connecting...")
        isScanning = false
        self.presentationMode = presentationMode
        self.baliseManager = baliseManager
        allCBPeripherals.forEach { p in
            if (p.identifier == peripheral.identifier) {
                myCentral.connect(p, options: nil)
                p.delegate = self
                connected = p
            }
        }
    }
    
    func startScanning() {
        peripherals.removeAll()
        isScanning = true
        print("Starting Scanning")
        myCentral.scanForPeripherals(withServices: [baliseService], options: nil)
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
            let newPeripheral = BLEPeripheral(id: peripherals.count, identifier: peripheral.identifier, name: peripheralName,  rssi: RSSI.intValue)
            peripherals.append(newPeripheral)
            allCBPeripherals.append(peripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        connected.discoverServices([baliseService])
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        } else {
            isSwitchedOn = false
        }
    }
}

extension BLEManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            print(service)
            peripheral.discoverCharacteristics([baliseIDCaracteristic], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard service.uuid == baliseService else {
            return
        }
        guard let characteristics = service.characteristics else { return }
        
        let caracteristic = characteristics.first {
            $0.uuid == baliseIDCaracteristic
        }!
        //peripheral.setNotifyValue(true, for: caracteristic)       Activer le notify value, va caller la funtion en dessous chaque fois que notify
        peripheral.readValue(for: caracteristic)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic)
        if characteristic.uuid == baliseIDCaracteristic {
            guard let data = characteristic.value else {
                // no data transmitted, handle if needed
                return
            }
            guard let stringData = String(data: data, encoding: .utf8) else { return }
            baliseManager.addBalise(id: stringData)
            myCentral.cancelPeripheralConnection(connected)
            presentationMode.wrappedValue.dismiss()
        }
    }
}
