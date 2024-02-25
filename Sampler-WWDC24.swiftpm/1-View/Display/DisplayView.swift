//
//  SwiftUIView.swift
//
//
//  Created by Henri Bredt on 24.02.24.
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var recorder: AudioRecorder
    @EnvironmentObject var audioEngine: AudioEngine
    
    var body: some View {
        VStack{
            HStack(alignment: .top, spacing: 19){
                            
                HStack(alignment: .center, spacing: 12){
                    DisplayTextItemView(text: "PLAY", size: .large, isOn: appState.selectedBank == nil, isBlinking: false, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                    DisplayTextItemView(text: "EDIT", size: .large, isOn: appState.selectedBank != nil, isBlinking: false, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                }
                .onDisplayPrintBorder(label: "MODE")
               
               
                HStack{
                    BankSelectionStatusView()
                    // make it flash !!!
                    DisplayTextItemView(text: "● RECORD", size: .large, isOn: recorder.isRecording, isBlinking: recorder.isPreRrecoring, onColor: Colors.displayOrangeColorOn, offColor: Colors.displayOrangeColorOff)
                }
                .onDisplayPrintBorder(label: "pad")
            }
            .padding(.bottom, 20)
            
            HStack(spacing: 19){
                VStack(spacing: 19){
                    
                    HStack{
                        Text("FX")
                            .onDisplayPrint()
                        Spacer()
                        EffectsSelectionStatusView()
                    }
                    
                    RangeProgressView(isOn: appState.selectedEffect != nil, width: 320, minValue: appState.selectedEffectMinValue, maxValue: appState.selectedEffectMaxValue, currentValue: appState.selectedEffectCurrentValue)
                }
                .padding(.vertical, 9.5)
                .frame(width: 320)
                .padding(.horizontal, 23)
                .onDisplayPrintBorder(label: "Effects")
                
                HStack(spacing: 10){
                    VStack(alignment: .leading, spacing: 10){
                        DisplayTextItemView(text: "No Selection", size: .small, isOn: false, isBlinking: appState.showInfoNoSelection, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                        DisplayTextItemView(text: "Duplicated", size: .small, isOn: false, isBlinking: appState.showInfoDuplicated, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                        DisplayTextItemView(text: "No sample", size: .small, isOn: false, isBlinking: appState.showInfoNoSample, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                    }
                    VStack(alignment: .trailing, spacing: 10){
                        DisplayTextItemView(text: "fx reset", size: .small, isOn: false, isBlinking: appState.showInfoFxReset, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                       
                        DisplayTextItemView(text: "max value", size: .small, isOn: false, isBlinking: appState.showInfoMaxValue, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                        DisplayTextItemView(text: "min value", size: .small, isOn: false, isBlinking: appState.showInfoMinValue, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
                       
                       
                    }
                }
                .onDisplayPrintBorder(label: "info")
            }
            
        }
        .padding()
        .frame(maxWidth: 800)
    }
}

#Preview {
    DisplayView()
}


// MARK: View Modifier

struct OnDisplayPrintBorderModifier: ViewModifier {
    let label: String
    
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 28, leading: 19, bottom: 19, trailing: 19))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Colors.printedOnDeviceColor, lineWidth: 1)
            )
            .overlay(
                Text(label)
                    .onDisplayPrint()
                    .padding(.horizontal, 10)
                    .background(Colors.displayColor)
                    .offset(x: 19, y: -8),
                alignment: .topLeading
            )
    }
}

extension View {
    func onDisplayPrintBorder(label: String) -> some View {
        self.modifier(OnDisplayPrintBorderModifier(label: label))
    }
}

struct OnDisplayPrintModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Colors.printedOnDeviceColor)
            .shadow(color: .black, radius: 3, x: 6, y: 6)
            .displayFont(size: .small)
    }
}

extension View {
    func onDisplayPrint() -> some View {
        self.modifier(OnDisplayPrintModifier())
    }
}

struct DisplayFontModifier: ViewModifier {
    let size: DisplayItemSize
    func body(content: Content) -> some View {
        content
            .font(size == .small ? .caption : . body)
            .fontWeight(.medium)
            .monospaced()
            .textCase(.uppercase)
    }
}

extension View {
    func displayFont(size: DisplayItemSize) -> some View {
        self.modifier(DisplayFontModifier(size: size))
    }
}
