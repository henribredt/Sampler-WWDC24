//
//  SwiftUIView.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import SwiftUI

struct DisplayTextItemView: View {
    let text: String
    let isOn: Bool
    let onColor: Color
    let offColor: Color
    
    var body: some View {
        Text(text)
            .displayFont()
            .fontWeight(.black)
            .foregroundStyle(Colors.displayColor)
            .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .foregroundStyle(isOn ? onColor : offColor)
            )
            .blur(radius: 0.5)
    }
}
#Preview {
    DisplayTextItemView(text: "1", isOn: true, onColor: Color.red, offColor: Color.blue)
}
