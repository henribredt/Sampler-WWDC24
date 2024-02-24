//
//  SwiftUIView.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import SwiftUI

struct EffectsSelectionStatusView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack{
            DisplayTextItemView(text: "gain", size: .small, isOn: appState.selectedEffect == .gain, isBlinking: false, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
            DisplayTextItemView(text: "pitch", size: .small, isOn: appState.selectedEffect == .pitch, isBlinking: false, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
            DisplayTextItemView(text: "low pass", size: .small, isOn: appState.selectedEffect == .lowpass, isBlinking: false, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
            DisplayTextItemView(text: "trim", size: .small, isOn: appState.selectedEffect == .trimFromStart, isBlinking: false, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
        }
    }
}

#Preview {
    EffectsSelectionStatusView()
}
