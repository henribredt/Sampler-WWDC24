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
    
    static func save(_ bankConfig: BankPlayerConfig, for bank: Bank) {
        do {
            let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documentsPath.appendingPathComponent("\(bank.getFileName()).json")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(bankConfig)
            try data.write(to: url)
            print("Person saved successfully as JSON")
        } catch {
            print("Error saving person as JSON: \(error.localizedDescription)")
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
            print("Error loading person from JSON: \(error.localizedDescription)")
            return nil
        }
    }
}

extension BankPlayerConfig {
    // returns a new, default BankPlayerConfig
    static func newDefault() -> BankPlayerConfig {
        BankPlayerConfig(pitch: 0)
    }
}