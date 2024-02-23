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
    
    @Published var selectedBankHasPitchEdit: Bool = false
    @Published var selectedBankHasLowPassEdit: Bool = false
    
    func toggleSelectedBank(base: Bank) {
        if selectedBank == nil || selectedBank != base {
            selectedBank = base
        } else {
            selectedBank = nil
            // if no bank is selected, no effect should be selected too
            selectedEffect = nil
        }
    }
    
    func toggleSelectedEffect(base: Effect) {
        if selectedEffect == nil || selectedEffect != base {
            selectedEffect = base
        } else {
            selectedEffect = nil
        }
    }
}
