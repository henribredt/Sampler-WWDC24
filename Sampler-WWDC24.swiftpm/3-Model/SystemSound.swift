//
//  File.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import Foundation

enum SystemSound {
    case recCountDown, invalidAction
    
    func getURL() -> URL {
        switch self {
        case .recCountDown:
            return Bundle.main.url(forResource: "drum", withExtension: "mp3")!
        case .invalidAction:
            return Bundle.main.url(forResource: "rangeBoundaryReached", withExtension: "wav")!
        }
    }
}
