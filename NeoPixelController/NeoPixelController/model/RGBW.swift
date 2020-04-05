//
//  RGBW.swift
//  NeoPixelController
//
//  Created by Choi on 2020/03/20.
//  Copyright © 2020 Choi. All rights reserved.
//

import Foundation

struct RGBW {
  var r: Int
  var g: Int
  var b: Int
  var w: Int

  init(r: Double, g: Double, b: Double, w: Double) {
    self.r = Int(r)
    self.g = Int(g)
    self.b = Int(b)
    self.w = Int(w)
  }

  func toString() -> String {
    return "<\(r)/\(g)/\(b)/\(w)>"
  }
}
