//
//  BluetoothManager.swift
//  NeoPixelController
//
//  Created by Choi on 2020/03/28.
//  Copyright © 2020 Choi. All rights reserved.
//

import Combine
import CoreBluetooth
import Foundation
import SwiftUI

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
  @State private var bluetoothState: CBManagerState = .unknown

  private var centralManager: CBCentralManager!
  private var peripheral: CBPeripheral?
  private var rxCharacteristic: CBCharacteristic?
  private var txCharacteristic: CBCharacteristic?

  /// 블루투스 상태확인
  /// - Parameter central: CBCentralManager
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .unsupported:
      print("central.state is .unsupported")
    case .unauthorized:
      print("central.state is .unauthorized")
    case .poweredOff:
      print("central.state is .poweredOff")
    case .poweredOn:
      print("central.state is .poweredOn")
      scanStart()
    default:
      print("central.state is default.")
    }
    bluetoothState = central.state
  }

  // 기기 찾기
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                      advertisementData: [String: Any], rssi RSSI: NSNumber) {
    if isRGBControllerBluetooth(name: peripheral.name ?? "") {
      self.peripheral = peripheral
      connect()
    }
  }

  // 연결하기
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    self.peripheral!.discoverServices(nil)
  }

  // 서비스 찾기
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    if let error = error {
      print("Discover error: \(error)")
      return
    }
    let services = peripheral.services
    peripheral.discoverCharacteristics(nil, for: (services?.first)!)
  }

  // characteristics 찾기
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                  error: Error?) {
    guard let characteristics = service.characteristics else { return }
    rxCharacteristic = characteristics.first
    txCharacteristic = characteristics.last
  }

  // 쓰기
  func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
    if error != nil {
      print("Write error: \(String(describing: error))")
      return
    }
  }

  func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    print("disconnect")
  }
}

extension BluetoothManager {
  /// 블루투스 시작
  func start() {
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }

  /// 스캔 시작
  func scanStart() {
    centralManager.scanForPeripherals(withServices: nil)
  }

  /// 스캔 종료
  func stopScan() {
    centralManager.stopScan()
  }

  /// 신호보내기
  /// - Parameter rgbw: RGBW
  func writeSingal(_ rgbw: String) {
    guard let charcteristic = txCharacteristic else { return }
    peripheral?.writeValue(rgbw.data(using: .utf8)!, for: charcteristic, type: .withResponse)
  }

  /// 연결하기
  func connect() {
    centralManager.connect(peripheral!, options: nil)
    stopScan()
    peripheral?.delegate = self
  }

  /// HM-10인지 확인하기
  /// - Parameter name: 블루투스 이름
  /// - Returns: Bool
  func isRGBControllerBluetooth(name: String) -> Bool {
    return name.contains("church")
  }

  /// 연결끊기
  func disconnect() {
    guard peripheral != nil else { return }
    centralManager.cancelPeripheralConnection(peripheral!)
  }

  /// String을 UTF8 데이터로 바꾸기
  /// - Parameter string: String
  /// - Returns: Data
  func stringToData(_ string: String) -> Data {
    return string.data(using: .utf8)!
  }
}
