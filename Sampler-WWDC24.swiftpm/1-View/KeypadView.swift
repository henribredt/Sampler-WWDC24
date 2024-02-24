//
//  KeypadView.swift
//  Sampler
//
//  Created by Henri Bredt on 21.02.24.
//

import SwiftUI

struct KeypadView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var recorder: AudioRecorder
    @EnvironmentObject var audioEngine: AudioEngine
    
    let audioPlayer: AudioPlayer
    
    var body: some View {
        VStack(spacing: 29) {
            HStack(spacing: 30) {
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "plus.forwardslash.minus") }, belowBtnLabel: "PITCH", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .pitch, statusLEDisBlinking: false, tapAction: {
                    effectTapAction(effect: .pitch)
                }, longPressAction: {
                    effectLongPressAction(effect: .pitch)
                })
                
                
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "line.3.horizontal.decrease") }, belowBtnLabel: "LOW PASS", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .lowpass, statusLEDisBlinking: false, tapAction: {
                    effectTapAction(effect: .lowpass)
                }, longPressAction: {
                    effectLongPressAction(effect: .lowpass)
                })
                
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "scissors") }, belowBtnLabel: "TRIM", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .gain, statusLEDisBlinking: false, tapAction: {
                    audioPlayer.playSystemSound(.toggleOff)
                }, longPressAction: {
                    
                })
                
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "speaker.wave.1") }, belowBtnLabel: "GAIN", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .gain, statusLEDisBlinking: false, tapAction: {
                    effectTapAction(effect: .gain)
                }, longPressAction: {
                    effectLongPressAction(effect: .gain)
                })
            }
            
            HStack(spacing: 30) {
                ButtonView(kind: .bank, onButtonLabelView: { Text("1") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank1), statusLEDisBlinking: appState.selectedBank == .bank1, tapAction: {
                    bankTapAction(.bank1)
                }, longPressAction: {
                    bankLongPressAction(.bank1)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("2") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank2),
                           statusLEDisBlinking: appState.selectedBank == .bank2, tapAction: {
                    bankTapAction(.bank2)
                }, longPressAction: {
                    bankLongPressAction(.bank2)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("3") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank3),
                           statusLEDisBlinking: appState.selectedBank == .bank3, tapAction: {
                    bankTapAction(.bank3)
                }, longPressAction: {
                    bankLongPressAction(.bank3)
                })
                
                ButtonView(kind: .control, onButtonLabelView: { Image(systemName: "plus") }, belowBtnLabel: "PLUS", showStatusLED: false,
                           statusLEDisOn: false, statusLEDisBlinking: false, tapAction: {
                    if let bank = appState.selectedBank {
                        switch appState.selectedEffect {
                        case .pitch:
                            audioPlayer.editPitch(for: bank, value: .increase)
                        case .lowpass :
                            audioPlayer.editLowPassFilter(for: bank, value: .increase)
                        case .gain:
                            audioPlayer.editGain(for: bank, value: .increase)
                        case .none:
                            return
                        }
                    } else {
                        audioPlayer.playSystemSound(.invalidAction)
                    }
                }, longPressAction: {
                    audioPlayer.playSystemSound(.invalidAction)
                })
                
            }
            
            HStack(spacing: 30) {
                ButtonView(kind: .bank, onButtonLabelView: { Text("4") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank4), statusLEDisBlinking: appState.selectedBank == .bank4, tapAction: {
                    bankTapAction(.bank4)
                }, longPressAction: {
                    bankLongPressAction(.bank4)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("5") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank5),
                           statusLEDisBlinking: appState.selectedBank == .bank5, tapAction: {
                    bankTapAction(.bank5)
                }, longPressAction: {
                    bankLongPressAction(.bank5)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("6") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank6),
                           statusLEDisBlinking: appState.selectedBank == .bank6, tapAction: {
                    bankTapAction(.bank6)
                }, longPressAction: {
                    bankLongPressAction(.bank6)
                })
                
                ButtonView(kind: .control, onButtonLabelView: { Image(systemName: "minus") }, belowBtnLabel: "MINUS", showStatusLED: false,
                           statusLEDisOn: false, statusLEDisBlinking: false, tapAction: {
                    if let bank = appState.selectedBank {
                        
                        switch appState.selectedEffect {
                        case .pitch:
                            audioPlayer.editPitch(for: bank, value: .decrease)
                        case .lowpass :
                            audioPlayer.editLowPassFilter(for: bank, value: .decrease)
                        case .gain:
                            audioPlayer.editGain(for: bank, value: .decrease)
                        case .none:
                            return
                        }
                    } else {
                        audioPlayer.playSystemSound(.invalidAction)
                    }
                }, longPressAction: {
                    audioPlayer.playSystemSound(.invalidAction)
                })
            }
            
            HStack(spacing: 30) {
                ButtonView(kind: .bank, onButtonLabelView: { Text("7") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank7), statusLEDisBlinking: appState.selectedBank == .bank7, tapAction: {
                    bankTapAction(.bank7)
                }, longPressAction: {
                    bankLongPressAction(.bank7)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("8") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank8),
                           statusLEDisBlinking: appState.selectedBank == .bank8, tapAction: {
                    bankTapAction(.bank8)
                }, longPressAction: {
                    bankLongPressAction(.bank8)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("9") }, belowBtnLabel: "PAD", showStatusLED: true, statusLEDisOn: audioPlayer.isPlaying(bank: .bank9),
                           statusLEDisBlinking: appState.selectedBank == .bank9, tapAction: {
                    bankTapAction(.bank9)
                }, longPressAction: {
                    bankLongPressAction(.bank9)
                })
                
                ButtonView(kind: .rec, onButtonLabelView: { Text("REC") }, belowBtnLabel: "REC", showStatusLED: true, statusLEDisOn: recorder.isRecording, statusLEDisBlinking: false, tapAction: {
                    guard let selectedBank = appState.selectedBank else {
                        audioPlayer.playSystemSound(.invalidAction)
                        return
                    }
                    
                    if recorder.isRecording {
                        recorder.stopRecording()
                        audioPlayer.playSystemSound(.toggleOff)
                        appState.selectedEffect = nil
                        appState.selectedBank = nil
                    } else {
                        audioPlayer.resetEffectsAndEdits(for: selectedBank)
                        let systemSoundDuration = audioPlayer.playSystemSound(.recCountDown)
                        
                        let timer = Timer.scheduledTimer(withTimeInterval: systemSoundDuration, repeats: false) { timer in
                            // Audio has finished playing, update playingBanks on the main thread
                            DispatchQueue.main.async {
                                recorder.startRecording(fileName: selectedBank.getFileName())
                                timer.invalidate()
                            }
                        }
                    }
                    
                }, longPressAction: {
                    if recorder.isRecording {
                        audioPlayer.playSystemSound(.toggleOff)
                        recorder.stopRecording()
                    } else {
                        audioPlayer.playSystemSound(.invalidAction)
                    }
                })
            }
        }
    }
    
    func bankTapAction(_ bank: Bank) {
        
        if appState.selectedBank == nil || appState.selectedBank == bank {
            // play sample if system is not in edit mode or if in edit mode of this bank
            audioPlayer.play(bank)
        } else {
            if !recorder.isRecording {
                // replace this with a solo  display warning
                audioPlayer.playSystemSound(.invalidAction)
            }
        }
    }
    
    func bankLongPressAction(_ bank: Bank) {
        if recorder.isRecording {
            recorder.stopRecording()
        }
        
        if appState.selectedBank == nil || appState.selectedBank == bank {
            audioPlayer.stopAllPlayers()
            let toggleResult = appState.toggleSelectedBank(base: bank)
            if toggleResult != nil {
                audioPlayer.playSystemSound(.toggleOn)
            } else {
                audioPlayer.playSystemSound(.toggleOff)
            }
        } else {
            // copy currentActiveBank to this bank and play
            copySampleFromSelectedTo(bank: bank)
            let systemSoundDuration = audioPlayer.playSystemSound(.toggleOff)
            let timer = Timer.scheduledTimer(withTimeInterval: systemSoundDuration, repeats: false) { timer in
                // Audio has finished playing, update playingBanks on the main thread
                DispatchQueue.main.async {
                    audioPlayer.play(bank)
                    timer.invalidate()
                }
            }
        }
    }
    
    
    // copy currentActiveBank to this bank
    func copySampleFromSelectedTo(bank: Bank) {
        // soundfile
        FileSystemManager.duplicateAndRenameFile(originalFileURL: FileSystemManager.audioFileURL(for: appState.selectedBank!), newFileName: "\(bank.getFileName()).wav")
        
        // config
        if let selectedBankConfig = BankPlayerConfig.load(for: appState.selectedBank!) {
            BankPlayerConfig.save(selectedBankConfig, for: bank)
        }
        
        appState.selectedEffect = nil
        appState.selectedBank = nil
    }
    
    func effectTapAction(effect: Effect) {
        if recorder.isRecording {
            return
        }
        
        // disable selected bank on tap after edit
        if appState.selectedEffect == effect && appState.selectedBank != nil {
            appState.selectedBank = nil
            appState.selectedEffect = nil
            audioPlayer.playSystemSound(.toggleOff)
        }
        
        if appState.selectedBank != nil {
            appState.toggleSelectedEffect(base: effect)
        } else {
            audioPlayer.playSystemSound(.invalidAction)
        }
    }
    
    func effectLongPressAction(effect: Effect) {
        if recorder.isRecording {
            return
        }
        
        // reset effect
        if let bank = appState.selectedBank {
            switch effect {
            case .pitch:
                audioPlayer.editPitch(for: bank, value: .reset)
            case .lowpass:
                audioPlayer.editLowPassFilter(for: bank, value: .reset)
            case .gain:
                audioPlayer.editGain(for: bank, value: .reset)
            }
        } else {
            audioPlayer.playSystemSound(.invalidAction)
        }
    }
}

#Preview {
    KeypadView(audioPlayer: AudioPlayer(audioEngine: AudioEngine()))
}

