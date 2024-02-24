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
            return 0.55
        case .trimFromStart:
            return 0
        }
    }
}
