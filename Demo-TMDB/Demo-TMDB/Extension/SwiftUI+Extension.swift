//
//  SwiftUI+Extension.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import SwiftUI
import UIKit


extension Color {
    init(uiColor: UIColor) {
        self.init(red: Double(uiColor.rgba.red),
                  green: Double(uiColor.rgba.green),
                  blue: Double(uiColor.rgba.blue),
                  opacity: Double(uiColor.rgba.alpha))
    }
}
