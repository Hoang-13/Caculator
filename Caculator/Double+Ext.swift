//
//  Double+Ext.swift
//  Caculator
//
//  Created by Nguyen Hoang Viet on 08/10/2021.
//

import Foundation

extension Double {
  func removeZerosFromEnd() -> String {
    let formatter = NumberFormatter()
    let number = NSNumber(value: self)
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 8
    return String(formatter.string(from: number) ?? "")
  }
}
