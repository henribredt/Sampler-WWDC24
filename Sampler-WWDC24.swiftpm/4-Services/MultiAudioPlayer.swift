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
        
        let audioFileURL = FileSystemManager.audioFileURL(for: bank)
        let playerIndex = bank.playerIndex()
        
        guard let config = BankPlayerConfig.load(for: bank) else {
            // if no config file could be loaded, play without any adjustments
            audioEngine.playSound(fileURL: audioFileURL, playerIndex: playerIndex)
            return
        }
        
        audioEngine.playSound(fileURL: audioFileURL, playerIndex: playerIndex, pitch: config.pitch, lowPassFrequency: config.lowPassFrequency, gain: config.gain)
    }
    
    func isPlaying(bank: Bank) -> Bool {
        return audioEngine.playingBanks.contains(bank)
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
            config.pitch += 200
        case .decrease:
            config.pitch -= 200
        case .reset:
            config.pitch = Effect.pitch.defaultValue()
        }
        
        BankPlayerConfig.save(config, for: bank)
        play(bank)
    }
    
    //MARK: LOWPASS
        func editLowPassFilter(for bank: Bank, value edit: EditValue) {
            var config: BankPlayerConfig
            
            if let oldConfig = BankPlayerConfig.load(for: bank) {
                config = oldConfig
            } else {
                // if no config file was found, create a new default config
                config = BankPlayerConfig.newDefault()
            }
            
            switch edit {
            case .increase:
                config.lowPassFrequency += 250
            case .decrease:
                if config.lowPassFrequency >= 250{
                    config.lowPassFrequency -= 250
                }
            case .reset:
                config.lowPassFrequency = Effect.lowpass.defaultValue()
            }
            
            BankPlayerConfig.save(config, for: bank)
            play(bank)
        }
    
    //MARK: GAIN
    func editGain(for bank: Bank, value edit: EditValue) {
        var config: BankPlayerConfig
        
        if let oldConfig = BankPlayerConfig.load(for: bank) {
            config = oldConfig
        } else {
            // if no config file was found, create a new default config
            config = BankPlayerConfig.newDefault()
        }
        
        switch edit {
        case .increase:
            if config.gain < 0.95 {
                config.gain += 0.1
            }
        case .decrease:
            if config.gain > 0.06 {
                config.gain -= 0.1
            }
        case .reset:
            config.gain = Effect.gain.defaultValue()
        }
        print("Gain: \(config.gain)")
        BankPlayerConfig.save(config, for: bank)
        play(bank)
    }
}
