//
//  SwiftUIView.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import SwiftUI

enum DisplayItemSize {
    case small, large
}

struct DisplayTextItemView: View {
    let text: String
    let size: DisplayItemSize
    let isOn: Bool
    let isBlinking: Bool
    let onColor: Color
    let offColor: Color
    
    var fillColorOn: LinearGradient { LinearGradient(colors: [onColor], startPoint: .top, endPoint: .bottom)
    }
    var fillColorOff: LinearGradient { LinearGradient(colors: [offColor], startPoint: .top, endPoint: .bottom)
        }
    
    var body: some View {
        Text(text)
            .displayFont(size: size)
            .fontWeight(.black)
            .foregroundStyle(Colors.displayColor)
            .padding(.vertical, size == .small ? 2 : 3)
            .padding(.horizontal, size == .small ? 6 : 9)
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .blinking(isBlinking: isBlinking, color1: fillColorOff, color2: fillColorOn)
                    .foregroundStyle(isBlinking ? offColor : isOn ? onColor : offColor)
            )
           
            .blur(radius: 0.5)
    }
}
#Preview {
    DisplayTextItemView(text: "1", size: .small, isOn: true, isBlinking: false, onColor: Color.red, offColor: Color.blue)
}
