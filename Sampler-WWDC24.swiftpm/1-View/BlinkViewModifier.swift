import SwiftUI

struct BlinkingBackgroundModifier: ViewModifier {
    let isBlinking: Bool
    let color1 = Colors.offStatusLEDGradient
    let color2 = Colors.onStatusLEDGradient
    
    @State private var internalBlinkingState = false
    
    func body(content: Content) -> some View {
        if !isBlinking {
            content
        } else {
            content
                .foregroundStyle(internalBlinkingState ? color1 : color2)
                .onAppear {
                    if isBlinking {
                        withAnimation(Animation.linear(duration: 0.05).delay(0.25).repeatForever()) {
                            internalBlinkingState = true
                        }
                    }
                }
                .onDisappear {
                    internalBlinkingState = false
                }
        }
    }
}

extension View {
    func blinking(isBlinking: Bool) -> some View {
        self.modifier(BlinkingBackgroundModifier(isBlinking: isBlinking))
    }
}
