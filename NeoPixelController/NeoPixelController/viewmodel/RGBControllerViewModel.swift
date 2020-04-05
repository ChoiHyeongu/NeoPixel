//
//  RGBControllerViewModel.swift
//  NeoPixelController
//
//  Created by Choi on 2020/04/04.
//  Copyright © 2020 Choi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class RGBControllerViewModel: ObservableObject {
  @Published var rgbw: RGBW? {
    didSet {
      guard let value = rgbw?.toString() else { return }
      manager.writeSingal(value)
    }
  }
  
  var manager = BluetoothManager()
  
  init() {
    configureBluetoohManager()
  }

  func configureBluetoohManager() {
    manager.start()
  }
}
