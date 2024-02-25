//
//  File.swift
//
//
//  Created by Henri Bredt on 23.02.24.
//

import Foundation

struct AudioPlayer {
    let audioEngine: AudioEngine
    let appState: AppState
    
    /// - returns: Duration of the playing systemSound
    @discardableResult
    func playSystemSound(_ systemSound: SystemSound) -> Double {
        return audioEngine.playSystemSound(systemSound)
    }
    
    func stopAllPlayers() {
        audioEngine.stopAllSounds()
    }
    
    func play(_ bank: Bank) {
        
        let audioFileURL = FileSystemManager.audioFileURL(for: bank)
        let playerIndex = bank.playerIndex()
        var playingWasSucessfull : Bool = false
        
        if let config = BankPlayerConfig.load(for: bank) {
            // play with config
            playingWasSucessfull = audioEngine.playSound(fileURL: audioFileURL, playerIndex: playerIndex, pitch: config.pitch, lowPassFrequency: config.lowPassFrequency, gain: config.gain, startTime: config.trimFromStart)
        } else {
            // if no config file could be loaded, play without any adjustments
            playingWasSucessfull = audioEngine.playSound(fileURL: audioFileURL, playerIndex: playerIndex)
        }
        
        // show UI info if no sample
        if playingWasSucessfull == false { appState.flashOnDisplay(info: .noSample) }
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
            if config.pitch < Effect.pitch.range().upperBound {
                config.pitch += Effect.pitch.stepSize()
            } else {
                appState.flashOnDisplay(info: .maxValue)
                skipPlay = true
            }
        case .decrease:
            if config.pitch > Effect.pitch.range().lowerBound {
                config.pitch -= Effect.pitch.stepSize()
            } else {
                appState.flashOnDisplay(info: .minValue)
                skipPlay = true
            }
        case .reset:
            config.pitch = Effect.pitch.defaultValue()
        }
        
        if !skipPlay {
            BankPlayerConfig.save(config, for: bank)
            play(bank)
        }
        appState.selectedEffectCurrentValue = Double(config.pitch)
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
                if config.lowPassFrequency < Effect.lowpass.range().upperBound {
                    config.lowPassFrequency += Effect.lowpass.stepSize()
                } else {
                    appState.flashOnDisplay(info: .minValue)
                    skipPlay = true
                }
            case .decrease:
                if config.lowPassFrequency > Effect.lowpass.range().lowerBound{
                    config.lowPassFrequency -= Effect.lowpass.stepSize()
                } else {
                    appState.flashOnDisplay(info: .maxValue)
                    skipPlay = true
                }
            case .reset:
                config.lowPassFrequency = Effect.lowpass.defaultValue()
            }
            
            if !skipPlay {
                BankPlayerConfig.save(config, for: bank)
                play(bank)
            }
            appState.selectedEffectCurrentValue = Double(config.lowPassFrequency)
            print(config)
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
            if config.gain < Effect.gain.range().upperBound {
                config.gain = min(1, config.gain + Effect.gain.stepSize())
            } else {
                appState.flashOnDisplay(info: .maxValue)
                skipPlay = true
            }
        case .decrease:
            if config.gain > Effect.gain.range().lowerBound {
                config.gain = max(0, config.gain - Effect.gain.stepSize())
            } else {
                appState.flashOnDisplay(info: .minValue)
                skipPlay = true
            }
        case .reset:
            config.gain = Effect.gain.defaultValue()
        }
        
        if !skipPlay {
            BankPlayerConfig.save(config, for: bank)
            play(bank)
        }
        appState.selectedEffectCurrentValue = Double(config.gain)
    }
    
    //MARK: TrimFromStart
    func editTrimFromStart(for bank: Bank, value edit: EditValue) {
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
            if config.trimFromStart < Double(Effect.trimFromStart.range().upperBound) {
                config.trimFromStart += Double(Effect.trimFromStart.stepSize())
            } else {
                appState.flashOnDisplay(info: .maxValue)
                skipPlay = true
            }
        case .decrease:
            if config.trimFromStart > Double(Effect.trimFromStart.range().lowerBound) {
                config.trimFromStart -= Double(Effect.trimFromStart.stepSize())
            } else if config.trimFromStart > 0 {
                config.trimFromStart = 0
            } else {
                appState.flashOnDisplay(info: .minValue)
                skipPlay = true
            }
        case .reset:
            config.trimFromStart = Double(Effect.trimFromStart.defaultValue())
        }
        
        if !skipPlay {
            BankPlayerConfig.save(config, for: bank)
            play(bank)
        }
        appState.selectedEffectCurrentValue = Double(config.trimFromStart)
    }
}
