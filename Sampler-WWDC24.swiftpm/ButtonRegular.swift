//
//  File.swift
//
//
//  Created by Henri Bredt on 22.02.24.
//

import SwiftUI

enum ButtonKind {
    case bank, rec, fx, control
    
    func getFill() -> LinearGradient {
        switch self {
        case .bank:
            return Colors.grayButtonGradient
        case .rec:
            return Colors.orangeButtonGradient
        case .fx:
            return Colors.darkGrayButtonGradient
        case .control:
            return Colors.blackButtonGradient
        }
    }
}

struct ButtonView: View {
    let kind: ButtonKind
    let onBtnLabel: String
    let belowBtnLabel: String
    let showStatusLED: Bool
    let statusLEDisOn: Bool
    let statusLEDisBlinking: Bool
    let tapAction: () -> ()
    let longPressAction: () -> ()
    
    var body: some View {
        VStack(alignment: .leading){
            Button(action: {
                // actions are defined as gestures
            }, label: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        .shadow(.inner(color: Color.white.opacity(0.4) ,radius: 2, x:2, y: 2))
                        .shadow(.inner(color: .black.opacity(0.3), radius: 2, x: -2, y: -2))
                    )
                    .foregroundStyle(kind.getFill())
                    .shadow(color: .black.opacity(0.25), radius: 5 , x: 8, y: 8)
                    .frame(width: 100, height: 100)
                    .overlay(alignment: .topLeading) {
                        Text(onBtnLabel)
                            .padding(14)
                            .font(.body.monospaced().weight(.semibold))
                            .foregroundStyle(Colors.labelColorWhite)
                    }
                    .padding(2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.black.opacity(0.75))
                    )
                    .onTapGesture {
                        tapAction()
                    }
                    .onLongPressGesture(minimumDuration: 0.2) {
                        longPressAction()
                    }
            })
            
            HStack(spacing: 10){
                Circle()
                    .fill(
                        .shadow(.inner(color: Color.black.opacity(0.5) ,radius: 1, x:0, y: 0))
                        .shadow(.inner(color: .black.opacity(0.2), radius: 2, x: 2, y: 2))
                    )
                    .foregroundStyle(statusLEDisOn ? Colors.onStatusLEDGradient : Colors.offStatusLEDGradient)
                    .frame(width: 16, height: 16)
                
                Text(belowBtnLabel)
                    .font(.footnote.monospaced().weight(.semibold))
                    .foregroundStyle(Colors.labelColorGrey)
            }
            .padding(EdgeInsets(top: 12, leading: 2, bottom: 0, trailing: 0))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    @State var isSelected: Bool = true
    @State var isBlinking: Bool = false
    
    return ButtonView(kind: .rec, onBtnLabel: "REC", belowBtnLabel: "RECORD", showStatusLED: true, statusLEDisOn: isSelected, statusLEDisBlinking: isBlinking, tapAction: {
        isSelected.toggle()
    }, longPressAction: {
        isBlinking.toggle()
    })
    .padding(30)
    .background(Color(hex: "b8b8b8"))
    
}
