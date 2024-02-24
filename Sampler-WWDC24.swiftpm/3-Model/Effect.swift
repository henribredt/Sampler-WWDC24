//
//  File.swift
//  
//
//  Created by Henri Bredt on 23.02.24.
//

import Foundation

enum Effect {
    case pitch, lowpass, gain
    
    func defaultValue() -> Float {
        switch self {
        case .pitch:
            return 0
        case .lowpass:
            return 4000
        case .gain:
            return 0.55
        }
    }
}
