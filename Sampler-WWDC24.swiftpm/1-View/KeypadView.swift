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
    
    let audioPlayer: MultiAudioPlayer
    
    var body: some View {
        VStack(spacing: 29) {
            HStack(spacing: 30) {
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "plus.forwardslash.minus") }, belowBtnLabel: "PITCH", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .pitch, statusLEDisBlinking: false, tapAction: {
                    
                    // disable selected bank on tap after edit
                    if appState.selectedEffect == .pitch && appState.selectedBank != nil {
                        appState.selectedBank = nil
                        appState.selectedEffect = nil
                    }
                    
                    if appState.selectedBank != nil {
                        appState.toggleSelectedEffect(base: .pitch)
                    }
                }, longPressAction: {
                    // reset pitch effect
                    if let bank = appState.selectedBank {
                        audioPlayer.editPitch(for: bank, value: .reset)
                    }
                })
                
                
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "line.3.horizontal.decrease") }, belowBtnLabel: "LOW PASS", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .lowpass, statusLEDisBlinking: false, tapAction: {
                    // disable selected bank on tap after edit
                    if appState.selectedEffect == .lowpass && appState.selectedBank != nil {
                        appState.selectedBank = nil
                        appState.selectedEffect = nil
                    }
                    
                    if appState.selectedBank != nil {
                        appState.toggleSelectedEffect(base: .lowpass)
                    }
                }, longPressAction: {
                    // reset lowpass effect
                    if let bank = appState.selectedBank {
                        audioPlayer.editLowPassFilter(for: bank, value: .reset)
                    }
                })
                
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "scissors") }, belowBtnLabel: "TRIM", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .gain, statusLEDisBlinking: false, tapAction: {
                    
                }, longPressAction: {
                    
                })
                
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "speaker.wave.1") }, belowBtnLabel: "GAIN", showStatusLED: true,
                           statusLEDisOn: appState.selectedEffect == .gain, statusLEDisBlinking: false, tapAction: {
                    // disable selected bank on tap after edit
                    if appState.selectedEffect == .gain && appState.selectedBank != nil {
                        appState.selectedBank = nil
                        appState.selectedEffect = nil
                    }
                    
                    if appState.selectedBank != nil {
                        appState.toggleSelectedEffect(base: .gain)
                    }
                }, longPressAction: {
                    // reset lowpass effect
                    if let bank = appState.selectedBank {
                        audioPlayer.editGain(for: bank, value: .reset)
                    }
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
                        
                    }
                }, longPressAction: {
                    
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
                    }
                }, longPressAction: {
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
                        return
                    }
                    
                    if recorder.isRecording {
                        recorder.audioRecorder.stop()
                        recorder.isRecording = false
                        appState.selectedEffect = nil
                        appState.selectedBank = nil
                    } else {
                        audioPlayer.resetEffectsAndEdits(for: selectedBank)
                        recorder.startRecording(fileName: selectedBank.getFileName())
                        recorder.isRecording = true
                    }
                    
                }, longPressAction: {
                    
                })
            }
        }
    }
    
    func bankTapAction(_ bank: Bank) {
        if appState.selectedBank == nil || appState.selectedBank == bank {
            // play sample if system is not in edit mode or if in edit mode of this bank
            audioPlayer.play(bank)
        } else {
            // copy currentActiveBank to this bank and play
            copySampleFromSelectedTo(bank: bank)
            audioPlayer.play(bank)
        }
    }
    
    func bankLongPressAction(_ bank: Bank) {
        appState.toggleSelectedBank(base: bank)
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
}

#Preview {
    KeypadView(audioPlayer: MultiAudioPlayer(audioEngine: AudioEngine()))
}

