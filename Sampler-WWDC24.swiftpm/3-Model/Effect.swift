//
//  File.swift
//  
//
//  Created by Henri Bredt on 23.02.24.
//

import Foundation

enum Effect {
    case pitch, lowpass, gain, trimFromStart
    
    func defaultValue() -> Float {
        switch self {
        case .pitch:
            return 0
        case .lowpass:
            return 4000
        case .gain:
            return 0.5
        case .trimFromStart:
            return 0
        }
    }
    
    func stepSize() -> Float {
        switch self {
        case .pitch:
            return 100
        case .lowpass:
            return 250
        case .gain:
            return 0.1
        case .trimFromStart:
            return 0.05
        }
    }
    
    func range() -> ClosedRange<Float> {
        switch self {
        case .pitch:
            return -1400...1400
        case .lowpass:
            // subtraieren von max zum ivertieren
            return 250...6500
        case .gain:
            return 0...1
        case .trimFromStart:
            return 0...2
        }
    }
}
