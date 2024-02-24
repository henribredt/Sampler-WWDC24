//
//  File.swift
//
//
//  Created by Henri Bredt on 23.02.24.
//

import Foundation

struct AudioPlayer {
    let audioEngine: AudioEngine
    
    func playSystemSound(_ systemSound: SystemSound) {
        audioEngine.playSystemSound(systemSound)
    }
    
    func stopAllPlayers() {
        audioEngine.stopAllSounds()
    }
    
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
extension AudioPlayer {
    
    func resetEffectsAndEdits(for bank: Bank){
        let config = BankPlayerConfig.newDefault()
        BankPlayerConfig.save(config, for: bank)
    }
    
    //MARK: PITCH
    func editPitch(for bank: Bank, value edit: EditValue) {
        var config: BankPlayerConfig
        var skipPlay = false
        
        if let oldConfig = BankPlayerConfig.load(for: bank) {
            config = oldConfig
        } else {
            // if no config file was found, create a new default config
            config = BankPlayerConfig.newDefault()
        }
        
        switch edit {
        case .increase:
            if config.pitch < 2200 {
                config.pitch += 200
            } else {
                playSystemSound(.invalidAction)
                skipPlay = true
            }
        case .decrease:
            if config.pitch > -2000 {
                config.pitch -= 200
            } else {
                playSystemSound(.invalidAction)
                skipPlay = true
            }
        case .reset:
            config.pitch = Effect.pitch.defaultValue()
        }
        
        if !skipPlay {
            BankPlayerConfig.save(config, for: bank)
            play(bank)
        }
    }
    
    //MARK: LOWPASS
        func editLowPassFilter(for bank: Bank, value edit: EditValue) {
            var config: BankPlayerConfig
            var skipPlay = false
            
            if let oldConfig = BankPlayerConfig.load(for: bank) {
                config = oldConfig
            } else {
                // if no config file was found, create a new default config
                config = BankPlayerConfig.newDefault()
            }
            
            switch edit {
            case .increase:
                if config.lowPassFrequency < 20000 {
                    config.lowPassFrequency += 250
                } else {
                    playSystemSound(.invalidAction)
                    skipPlay = true
                }
            case .decrease:
                if config.lowPassFrequency > 250{
                    config.lowPassFrequency -= 250
                } else {
                    playSystemSound(.invalidAction)
                    skipPlay = true
                }
            case .reset:
                config.lowPassFrequency = Effect.lowpass.defaultValue()
            }
            
            if !skipPlay {
                BankPlayerConfig.save(config, for: bank)
                play(bank)
            }
        }
    
    //MARK: GAIN
    func editGain(for bank: Bank, value edit: EditValue) {
        var config: BankPlayerConfig
        var skipPlay = false
        
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
            } else {
                playSystemSound(.invalidAction)
                skipPlay = true
            }
        case .decrease:
            if config.gain > 0.06 {
                config.gain -= 0.1
            } else {
                playSystemSound(.invalidAction)
                skipPlay = true
            }
        case .reset:
            config.gain = Effect.gain.defaultValue()
        }
        
        if !skipPlay {
            BankPlayerConfig.save(config, for: bank)
            play(bank)
        }
    }
}
