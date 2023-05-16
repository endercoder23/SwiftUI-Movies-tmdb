//
//  UIKit+Extension.swift
//  Alamofire5Example
//
//  Created by Dharam-007 on 15/05/23.
//

import UIKit
import SwiftUI


extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }

    typealias HSB = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat)?

    var hsbValues: HSB {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0

        let getHueValue = getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)

        guard getHueValue else {
            return nil
        }

        return (hue: hue, saturation: saturation, brightness: brightness)
    }

    var isLightColor: Bool {
        guard let hsb = hsbValues else {
            return false
        }

        return hsb.brightness > 0.75 && (hsb.saturation < 0.5 || (hsb.hue >= 0.05 && hsb.hue <= 0.55))
    }

    convenience init(hex: String) {
        let stringRepresentation = hex.replacingOccurrences(of: "#", with: "")

        guard let hexInt = Int(stringRepresentation, radix: 16) else {
            self.init(white: 0, alpha: 0)

            return
        }

        let red = CGFloat((hexInt >> 16) & 0xFF) / 255.0
        let green = CGFloat((hexInt >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hexInt & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}

// Update for iOS 15
// MARK: - UIApplication extension for resgning keyboard on pressing the cancel buttion of the search bar
extension UIApplication {
    /// Resigns the keyboard.
    ///
    /// Used for resigning the keyboard when pressing the cancel button in a searchbar based on [this](https://stackoverflow.com/a/58473985/3687284) solution.
    /// - Parameter force: set true to resign the keyboard.
    func endEditing(_ force: Bool) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}
    
struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
    
extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
