//
//  File.swift
//  
//
//  Created by Henri Bredt on 23.02.24.
//

import Foundation

struct BankPlayerConfig: Codable {
    
    /// Pitch value,
    /// Range: -2400 ... 2.400, 100 is a half tone
    var pitch: Float
    
    /// Suggested range: 20.000 .... 20
    /// If set to upper values -> less effect
    /// If set to lower values -> high effect
    var lowPassFrequency: Float
    
    /// Volume, Range: 0. .. 1
    var gain: Float
    
    /// Trim audio file from start, in seconds 0 ... duration
    var trimFromStart: Double
    
    static func save(_ bankConfig: BankPlayerConfig, for bank: Bank) {
        do {
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documentsPath.appendingPathComponent("\(bank.getFileName()).json")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(bankConfig)
            try data.write(to: url)
            print("Config saved successfully as JSON")
        } catch {
            print("Could not save config as JSON: \(error.localizedDescription)")
        }
    }
    
    static func load(for bank: Bank) -> BankPlayerConfig? {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsPath.appendingPathComponent("\(bank.getFileName()).json")
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let bankConfig = try decoder.decode(BankPlayerConfig.self, from: data)
            return bankConfig
        } catch {
            print("No config saved yet. Could not load config from JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getCurrentValueFor(_ effect: Effect) -> Float{
        switch effect {
        case .pitch:
            return pitch
        case .lowpass:
            return lowPassFrequency
        case .gain:
            return gain
        case .trimFromStart:
            return Float(trimFromStart)
        }
    }
}

extension BankPlayerConfig {
    // returns a new, default BankPlayerConfig
    static func newDefault() -> BankPlayerConfig {
        BankPlayerConfig(pitch: Effect.pitch.defaultValue(), lowPassFrequency: Effect.lowpass.defaultValue() , gain: Effect.gain.defaultValue(), trimFromStart: Double(Effect.trimFromStart.defaultValue()))
    }
}
