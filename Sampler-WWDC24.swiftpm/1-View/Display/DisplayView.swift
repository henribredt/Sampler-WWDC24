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
        VStack(spacing: 16){
           
           
            
            HStack{
                Text("SAMPLE")
                    .onDisplayPrint()
                   
                Spacer()
                BankSelectionStatusView()
            }
            
            HStack{
                Text("FX")
                    .onDisplayPrint()
                Spacer()
                EffectsSelectionStatusView()
            }
            
            RangeProgressView(isOn: appState.selectedEffect != nil, width: 300, minValue: appState.selectedEffectMinValue, maxValue: appState.selectedEffectMaxValue, currentValue: appState.selectedEffectCurrentValue)
        }
        .frame(width: 300)
    }
}

#Preview {
    DisplayView()
}


// MARK: View Modifier

struct OnDisplayPrintModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Colors.printedOnDeviceColor)
            .shadow(color: .black, radius: 3, x: 6, y: 6)
            .displayFont()
    }
}

extension View {
    func onDisplayPrint() -> some View {
        self.modifier(OnDisplayPrintModifier())
    }
}

struct DisplayFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .fontWeight(.medium)
            .monospaced()
            .textCase(.uppercase)
    }
}

extension View {
    func displayFont() -> some View {
        self.modifier(DisplayFontModifier())
    }
}
