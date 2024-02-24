//
//  File.swift
//
//
//  Created by Henri Bredt on 21.02.24.
//

import SwiftUI

struct Colors {
    private init() {}
    
    static let displayColor = Color(hex: "0F0F11")
    
    static let printedOnDeviceColor = Color(hex: "B8B8B8")
    
    static let displayOrangeColorOff = Color(hex: "511202")
    static let displayOrangeColorOn = Color(hex: "FD3300")
    static let displayPurpleColorOn = Color(hex: "2C61FF")
    static let displayPurpleColorOff = Color(hex: "0D1E51")
    
    static let labelColorWhite = Color(hex: "E5E5E5")
    static let labelColorGrey = Color(hex: "4B4B4B")
    
    static let deviceColorGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: "C8C8C8"), Color(hex: "A1A1A1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let grayButtonGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: "AAA5A5"), Color(hex: "8F8F8F")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let orangeButtonGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: "EC4C2C"), Color(hex: "E75127")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let blackButtonGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: "323232"), Color(hex: "2C2C2C")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let darkGrayButtonGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: "6E6E6E"), Color(hex: "565555")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let onStatusLEDGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: "D63A1E"), Color(hex: "E99E3D")]), startPoint: .topLeading, endPoint: .bottomTrailing)
    static let offStatusLEDGradient = LinearGradient(gradient: Gradient(colors: [Color(hex: "686868"), Color(hex: "B0B0B0")]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
