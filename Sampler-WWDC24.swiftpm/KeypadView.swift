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
    
    var body: some View {
        VStack(spacing: 29) {
            HStack(spacing: 30) {
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "wand.and.stars") }, belowBtnLabel: "PITCH", showStatusLED: true,
                           statusLEDisOn: appState.fxPitchIsActive, statusLEDisBlinking: false, tapAction: {
                    appState.fxPitchIsActive.toggle()
                }, longPressAction: {
                })
                
                /*
                ButtonView(kind: .fx, onButtonLabelView: { Image(systemName: "scissors") }, belowBtnLabel: "CUT", showStatusLED: true,
                           statusLEDisOn: false, statusLEDisBlinking: false, tapAction: {
                   
                }, longPressAction: {
                })
                */
                
                ButtonView(kind: .control, onButtonLabelView: { Image(systemName: "plus") }, belowBtnLabel: "PLUS", showStatusLED: false,
                           statusLEDisOn: false, statusLEDisBlinking: false, tapAction: {
                    if let bank = appState.selectedBank {
                        recorder.increasePitch(bank: bank)
                    }
                }, longPressAction: {
                    
                })
                
                ButtonView(kind: .control, onButtonLabelView: { Image(systemName: "minus") }, belowBtnLabel: "MINUS", showStatusLED: false,
                           statusLEDisOn: false, statusLEDisBlinking: false, tapAction: {
                    if let bank = appState.selectedBank {
                        recorder.decreasePitch(bank: bank)
                    }
                }, longPressAction: {
                })
            }
            
            HStack(spacing: 30) {
                ButtonView(kind: .bank, onButtonLabelView: { Text("1") }, belowBtnLabel: "BANK", showStatusLED: true,
                           statusLEDisOn: recorder.playingBanks.contains(.bank1) || appState.selectedBank == .bank1, statusLEDisBlinking: false, tapAction: {
                    recorder.playx(bank: .bank1, pitchy: 2)
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank1)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("2") }, belowBtnLabel: "BANK", showStatusLED: true,
                           statusLEDisOn: recorder.playingBanks.contains(.bank2) || appState.selectedBank == .bank2,
                           statusLEDisBlinking: false, tapAction: {
                    recorder.playRecoding(bank: .bank2)
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank2)
                })
                
                ButtonView(kind: .bank, onButtonLabelView: { Text("3") }, belowBtnLabel: "BANK", showStatusLED: true,
                           statusLEDisOn: recorder.playingBanks.contains(.bank3) || appState.selectedBank == .bank3,
                           statusLEDisBlinking: false, tapAction: {
                    recorder.playRecoding(bank: .bank3)
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
                        appState.selectedBank = nil
                    } else {
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
    KeypadView()
}

