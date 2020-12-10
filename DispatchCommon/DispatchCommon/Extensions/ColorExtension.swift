//
//  ColorExtension.swift
//  DispatchCommon
//
//  Created by Jiang, John X. -ND on 10/30/20.
//

import SwiftUI

public extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xff) / 255.0,
            green: Double((hex >> 8) & 0xff) / 255.0,
            blue: Double(hex & 0xff) / 255.0
        )
    }
}
