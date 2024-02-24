//
//  File.swift
//  
//
//  Created by Henri Bredt on 24.02.24.
//

import SwiftUI

struct RangeProgressView: View {
    let isOn: Bool
    let width: CGFloat
    var minValue: CGFloat
    var maxValue: CGFloat
    var currentValue: CGFloat

    var body: some View {
        
            VStack(alignment: .leading, spacing: 3) {
//                Text("Effect intensity")
//                    .displayFont()
//                    .padding(.bottom, 8)
                Rectangle()
                    .frame(width: width, height: 1)
                    .onDisplayPrint()
            
                Triangle()
                    .blur(radius: 1)
                    .frame(width: 16, height: 16)
                    .foregroundStyle(isOn ? Colors.displayOrangeColorOn : Colors.displayOrangeColorOff)
                    .offset(y: 2)
                    .offset(x: self.calculateTrianglePosition())
        }
    }

    private func calculateProgressWidth() -> CGFloat {
        let progress = (currentValue - minValue) / (maxValue - minValue)
        return progress * width
    }

    private func calculateTrianglePosition() -> CGFloat {
        let progress = (currentValue - minValue) / (maxValue - minValue)
        return progress * width - 8
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

#Preview{
    RangeProgressView(isOn: true, width: 200, minValue: 0, maxValue: 1, currentValue: 0.9)
        .padding()
        .frame(width: 200)
}
