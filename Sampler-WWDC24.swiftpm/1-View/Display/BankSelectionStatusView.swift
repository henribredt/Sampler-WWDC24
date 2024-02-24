//
//  SwiftUIView.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import SwiftUI

struct BankSelectionStatusView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 6.6) {
            ForEach(1...9, id: \.self) { number in
                DisplayTextItemView(text: "\(number)", isOn: (appState.selectedBank?.playerIndex() ?? -99)+1 == number, onColor: Colors.displayOrangeColorOn, offColor: Colors.displayOrangeColorOff)
            }
        }
    }
}

#Preview {
    BankSelectionStatusView()
}
