//
//  AppState.swift
//  Sampler
//
//  Created by Henri Bredt on 21.02.24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var editModeIsActive = false
    @Published var selectedBank: Bank? = nil
    
    func toggleSelectedBank(base: Bank) {
        if selectedBank == nil || selectedBank != base {
            selectedBank = base
            editModeIsActive = true
        } else {
            selectedBank = nil
            editModeIsActive = false
        }
    }
    
    @Published var fxPitchIsActive = false
    @Published var fxLoIsActive = false
    @Published var fxHiIsActive = false
    @Published var fxBandIsActive = false
    @Published var recIsActive = false
    @Published var buttonPlusIsActive = false
    @Published var buttonMinusIsActive = false
    
    @Published var button1IsActive = false
    @Published var button2IsActive = false
    @Published var button3IsActive = false
    @Published var button4IsActive = false
    @Published var button5IsActive = false
    @Published var button6IsActive = false
    @Published var button7IsActive = false
    @Published var button8IsActive = false
    @Published var button9IsActive = false
}
