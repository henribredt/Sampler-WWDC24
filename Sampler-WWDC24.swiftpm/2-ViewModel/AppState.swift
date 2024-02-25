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
    
    @Published var showInfoNoSelection: Bool = false
    var showInfoNoSelectionTimer: Timer? = nil
    
    @Published var showInfoDuplicated: Bool = false
    var showInfoDuplicatedTimer: Timer? = nil
    
    @Published var showInfoNoSample: Bool = false
    var showInfoNoSampleTimer: Timer? = nil
    
    @Published var showInfoFxReset: Bool = false
    var showInfoFxResetTimer: Timer? = nil
    
    @Published var showInfoMaxValue: Bool = false
    var showInfoMaxValueTimer: Timer? = nil
    
    @Published var showInfoMinValue: Bool = false
    var showInfoMinValueTimer: Timer? = nil
    
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
    
    // handles flashing the represented UI element for 2.5s
    // this might no be the very best code i've written, but its late night and it works
    let duration = 0.9
    let longDuration = 1.9
    func flashOnDisplay(info: InfoStatus) {
        switch info {
        case .noSelection:
            showInfoNoSelectionTimer?.invalidate()
            showInfoNoSelection = true
            showInfoNoSelectionTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
                DispatchQueue.main.async { [self] in
                    showInfoNoSelection = false
                    timer.invalidate()
                    showInfoNoSelectionTimer = nil
                }
            }
            
        case .duplicated:
            showInfoDuplicatedTimer?.invalidate()
            showInfoDuplicated = true
            showInfoDuplicatedTimer = Timer.scheduledTimer(withTimeInterval: longDuration, repeats: false) { timer in
                DispatchQueue.main.async { [self] in
                    showInfoDuplicated = false
                    timer.invalidate()
                    showInfoDuplicatedTimer = nil
                }
            }
            
        case .noSample:
            showInfoNoSampleTimer?.invalidate()
            showInfoNoSample = true
            showInfoNoSampleTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
                DispatchQueue.main.async { [self] in
                    showInfoNoSample = false
                    timer.invalidate()
                    showInfoNoSampleTimer = nil
                }
            }
            
        case .fxReset:
            showInfoFxResetTimer?.invalidate()
            showInfoFxReset = true
            showInfoFxResetTimer = Timer.scheduledTimer(withTimeInterval: longDuration, repeats: false) { timer in
                DispatchQueue.main.async { [self] in
                    showInfoFxReset = false
                    timer.invalidate()
                    showInfoFxResetTimer = nil
                }
            }
            
        case .maxValue:
            showInfoMaxValueTimer?.invalidate()
            showInfoMaxValue = true
            showInfoMaxValueTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
                DispatchQueue.main.async { [self] in
                    showInfoMaxValue = false
                    timer.invalidate()
                    showInfoMaxValueTimer = nil
                }
            }
            
        case .minValue:
            showInfoMinValueTimer?.invalidate()
            showInfoMinValue = true
            showInfoMinValueTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { timer in
                DispatchQueue.main.async { [self] in
                    showInfoMinValue = false
                    timer.invalidate()
                    showInfoMinValueTimer = nil
                }
            }
        }
    }
}

enum InfoStatus {
    case noSelection, duplicated, noSample, fxReset, maxValue, minValue
}
