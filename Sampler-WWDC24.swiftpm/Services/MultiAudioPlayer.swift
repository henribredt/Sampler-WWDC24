//
//  File.swift
//
//
//  Created by Henri Bredt on 23.02.24.
//

import Foundation

struct MultiAudioPlayer {
    let audioEngine: AudioEngine
    
    func play(_ bank: Bank) {
        
        let audioFileURL = audioFileURL(for: bank)
        let playerIndex = bank.playerIndex()
        
        guard let config = BankPlayerConfig.load(for: bank) else {
            // if no config file could be loaded, play without any adjustments
            audioEngine.playSound(fileURL: audioFileURL, playerIndex: playerIndex)
            return
        }
        
        audioEngine.playSound(fileURL: audioFileURL, playerIndex: playerIndex, pitch: config.pitch)
    }
    
    func audioFileURL(for bank: Bank) -> URL {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileURL = documentsPath.appendingPathComponent("\(bank.getFileName()).wav")
        return audioFileURL
    }
}

enum EditValue {
    case increase, decrease, reset
}

// MARK: Sound effects and edits
extension MultiAudioPlayer {
    
    func resetEffectsAndEdits(for bank: Bank){
        let config = BankPlayerConfig.newDefault()
        BankPlayerConfig.save(config, for: bank)
    }
    
    //MARK: PITCH
    func editPitch(for bank: Bank, value edit: EditValue) {
        var config: BankPlayerConfig
        
        if let oldConfig = BankPlayerConfig.load(for: bank) {
            config = oldConfig
        } else {
            // if no config file was found, create a new default config
            config = BankPlayerConfig.newDefault()
        }
        
        switch edit {
        case .increase:
            config.pitch += 100
        case .decrease:
            config.pitch -= 100
        case .reset:
            config.pitch = 0
        }
        
        BankPlayerConfig.save(config, for: bank)
        play(bank)
    }
}
