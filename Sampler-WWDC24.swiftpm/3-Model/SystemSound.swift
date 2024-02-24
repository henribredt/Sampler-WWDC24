//
//  File.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import Foundation

enum SystemSound {
    case recCountDown, invalidAction, toggleOn, toggleOff
    
    func getURL() -> URL {
        switch self {
        case .recCountDown:
            return Bundle.main.url(forResource: "recCountDown", withExtension: "mp3")!
        case .invalidAction:
            return Bundle.main.url(forResource: "rangeBoundaryReached", withExtension: "wav")!
        case .toggleOn:
            return Bundle.main.url(forResource: "toggle_on", withExtension: "wav")!
        case .toggleOff:
            return Bundle.main.url(forResource: "toggle_off", withExtension: "wav")!
        }
    }
}
