//
//  KeypadView.swift
//  Sampler
//
//  Created by Henri Bredt on 21.02.24.
//

import SwiftUI
/*
struct KeypadView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 29){
           
            HStack(spacing: 32) {
                ButtonDefault(role: .fx, isActive: appState.fxPitchIsActive, onButtonLabel: "", belowButtonLabel: "PITCH", tapAction: {
                    appState.fxPitchIsActive.toggle()
                }, longPressAction: {
                    
                })
                ButtonDefault(role: .fx, isActive: appState.fxLoIsActive, onButtonLabel: "", belowButtonLabel: "HIGH", tapAction: {
                    appState.fxLoIsActive.toggle()
                }, longPressAction: {
                    
                })
                ButtonDefault(role: .fx, isActive: appState.fxHiIsActive, onButtonLabel: "", belowButtonLabel: "LOW", tapAction: {
                    appState.fxHiIsActive.toggle()
                }, longPressAction: {
                    
                })
                ButtonDefault(role: .fx, isActive: appState.fxBandIsActive, onButtonLabel: "", belowButtonLabel: "BAND", tapAction: {
                    appState.fxBandIsActive.toggle()
                }, longPressAction: {
                    
                })
            }
            HStack(spacing: 32) {
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank1, onButtonLabel: "1", belowButtonLabel: "BANK", tapAction: {
                    AudioEngine.playSound()
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank1)
                })
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank2, onButtonLabel: "2", belowButtonLabel: "BANK", tapAction: {
                    print("tap")
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank2)
                })
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank3, onButtonLabel: "3", belowButtonLabel: "BANK", tapAction: {
                    print("tap")
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank3)
                })
                ButtonDefault(role: .control, isActive: false, onButtonLabel: "+", belowButtonLabel: "PLUS", showStatusLED: false, tapAction: {
                    print("tap")
                }, longPressAction: {
                    print("tap")
                })
            }
            HStack(spacing: 32) {
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank4, onButtonLabel: "4", belowButtonLabel: "BANK", tapAction: {
                    print("tap")
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank4)
                })
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank5, onButtonLabel: "5", belowButtonLabel: "BANK", tapAction: {
                    print("tap")
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank5)
                })
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank6, onButtonLabel: "6", belowButtonLabel: "BANK", tapAction: {
                    print("tap")
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank6)
                })
                ButtonDefault(role: .control, isActive: false, onButtonLabel: "−", belowButtonLabel: "MINUS", showStatusLED: false, tapAction: {
                    print("tap")
                }, longPressAction: {
                    print("tap")
                })
            }
            HStack(spacing: 32) {
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank7, onButtonLabel: "7", belowButtonLabel: "BANK", tapAction: {
                    print("tap")
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank7)
                })
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank8, onButtonLabel: "8", belowButtonLabel: "BANK", tapAction: {
                    print("tap")
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank8)
                })
                ButtonDefault(role: .regular, isActive: appState.selectedBank == .bank9, onButtonLabel: "9", belowButtonLabel: "BANK", tapAction: {
                    
                }, longPressAction: {
                    appState.toggleSelectedBank(base: .bank9)
                })
                ButtonDefault(role: .rec, isActive: appState.recIsActive, onButtonLabel: "REC", belowButtonLabel: "REC", tapAction: {
                    appState.recIsActive.toggle()
                }, longPressAction: {
                    print("tap")
                })
            }
        }
    }
             
}

#Preview {
    KeypadView()
}
             */
