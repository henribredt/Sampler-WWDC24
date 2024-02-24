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
            DisplayTextItemView(text: "gain", isOn: appState.selectedEffect == .gain, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
            DisplayTextItemView(text: "pitch", isOn: appState.selectedEffect == .pitch, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
            DisplayTextItemView(text: "low pass", isOn: appState.selectedEffect == .lowpass, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
            DisplayTextItemView(text: "trim", isOn: appState.selectedEffect == .trimFromStart, onColor: Colors.displayPurpleColorOn, offColor: Colors.displayPurpleColorOff)
        }
    }
}

#Preview {
    EffectsSelectionStatusView()
}
