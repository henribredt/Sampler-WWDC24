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
                
                
                ButtonView(kind: .control, onButtonLabelView: { Image(systemName: "plus") }, belowBtnLabel: "PLUS", showStatusLED: false,
                           statusLEDisOn: false, statusLEDisBlinking: false, tapAction: {
                    if let bank = appState.selectedBank {
                        switch appState.selectedEffect {
                        case .pitch:
                            audioPlayer.editPitch(for: bank, value: .increase)
                        case .lowpass :
                            audioPlayer.editLowPassFilter(for: bank, value: .increase)
                        case .none:
                            return
                        }
                        
                    }
                }, longPressAction: {
                    
                })
                
                ButtonView(kind: .control, onButtonLabelView: { Image(systemName: "minus") }, belowBtnLabel: "MINUS", showStatusLED: false,
                           statusLEDisOn: false, statusLEDisBlinking: false, tapAction: {
                    if let bank = appState.selectedBank {
                        
                        switch appState.selectedEffect {
                        case .pitch:
                            audioPlayer.editPitch(for: bank, value: .decrease)
                        case .lowpass :
                            audioPlayer.editLowPassFilter(for: bank, value: .decrease)
                        case .none:
                            return
                        }
                    }
                }, longPressAction: {
                })
            }
            
            HStack(spacing: 30) {
                ButtonView(kind: .bank, onButtonLabelView: { Text("1") }, belowBtnLabel: "BANK", showStatusLED: true,
                           statusLEDisOn: audioPlayer.isPlaying(bank: .bank1), statusLEDisBlinking: appState.selectedBank == .bank1, tapAction: {
                    audioPlayer.play(.bank1)
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank1)
                   
                    // might do: load config and show in the UI
                    // might also allow disabeling specific fxs
                    //let config = BankPlayerConfig.load(for: .bank1)
                    
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("2") }, belowBtnLabel: "BANK", showStatusLED: true,
                           statusLEDisOn: audioPlayer.isPlaying(bank: .bank2),
                           statusLEDisBlinking: appState.selectedBank == .bank2, tapAction: {
                    audioPlayer.play(.bank2)
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank2)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("3") }, belowBtnLabel: "BANK", showStatusLED: true,
                           statusLEDisOn: audioPlayer.isPlaying(bank: .bank3),
                           statusLEDisBlinking: appState.selectedBank == .bank3, tapAction: {
                    audioPlayer.play(.bank3)
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank3)
                })
                
                ButtonView(kind: .rec, onButtonLabelView: { Text("REC") }, belowBtnLabel: "REC", showStatusLED: true, statusLEDisOn: recorder.isRecording, statusLEDisBlinking: false, tapAction: {
                    guard let selectedBank = appState.selectedBank else {
                        return
                    }
                    
                    if recorder.isRecording {
                        recorder.audioRecorder.stop()
                        recorder.isRecording = false
                        
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
    
}

#Preview {
    KeypadView(audioPlayer: MultiAudioPlayer(audioEngine: AudioEngine()))
}

