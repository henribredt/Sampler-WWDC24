//
//  SwiftUIView.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import SwiftUI

struct BankSelectionStatusView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var audioEngine: AudioEngine
    
    var body: some View {
        HStack(spacing: 6.6) {
            ForEach(1...9, id: \.self) { number in
                DisplayTextItemView(text: "\(number)", size: .large, isOn: (appState.selectedBank?.playerIndex() ?? -99)+1 == number || audioEngine.playingBanks.contains(Bank.from(playerIndex: number-1)!), isBlinking: false, onColor: Colors.displayOrangeColorOn, offColor: Colors.displayOrangeColorOff)
            }
        }
    }
}

#Preview {
    BankSelectionStatusView()
}
