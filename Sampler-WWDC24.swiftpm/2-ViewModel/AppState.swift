//
//  AppState.swift
//  Sampler
//
//  Created by Henri Bredt on 21.02.24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var selectedBank: Bank? = nil
    @Published var selectedEffect: Effect? = nil
    
    // for Display
    @Published var selectedEffectMinValue: Double = 0
    @Published var selectedEffectMaxValue: Double = 1
    @Published var selectedEffectCurrentValue: Double = 0.5
    
    @discardableResult
    func toggleSelectedBank(base: Bank) -> Bank? {
        if selectedBank == nil || selectedBank != base {
            selectedBank = base
            return base
        } else {
            selectedBank = nil
            // if no bank is selected, no effect should be selected too
            selectedEffect = nil
            return nil
        }
    }
    
    func toggleSelectedEffect(base: Effect) {
        if selectedEffect == nil || selectedEffect != base {
            selectedEffect = base
            updateEffectRangeValues(effect: base)
            
            // update current Effect value
            let currentConfig = BankPlayerConfig.load(for: selectedBank!)
            selectedEffectCurrentValue = Double(currentConfig?.getCurrentValueFor(base) ?? 0)
        } else {
            selectedEffect = nil
        }
    }
    
    func updateEffectRangeValues(effect: Effect) {
        if effect == .lowpass {
            // invert for lowpasss
            selectedEffectMinValue = Double(effect.range().upperBound)
            selectedEffectMaxValue = Double(effect.range().lowerBound)
        } else {
            selectedEffectMinValue = Double(effect.range().lowerBound)
            selectedEffectMaxValue = Double(effect.range().upperBound)
        }
    }
}
