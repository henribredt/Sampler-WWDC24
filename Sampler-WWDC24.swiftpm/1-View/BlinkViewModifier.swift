import SwiftUI

struct BlinkingBackgroundModifier: ViewModifier {
    let isBlinking: Bool
    let color1: LinearGradient
    let color2: LinearGradient
    
    @State private var internalBlinkingState = false
    
    func body(content: Content) -> some View {
        if !isBlinking {
            content
        } else {
            content
                .foregroundStyle(internalBlinkingState ? color1 : color2)
                .onAppear {
                    if isBlinking {
                        withAnimation(Animation.linear(duration: 0.05).delay(0.2).repeatForever()) {
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
        self.modifier(BlinkingBackgroundModifier(isBlinking: isBlinking, color1: Colors.offStatusLEDGradient, color2: Colors.onStatusLEDGradient))
    }
    
    func blinking(isBlinking: Bool, color1: LinearGradient, color2: LinearGradient) -> some View {
            self.modifier(BlinkingBackgroundModifier(isBlinking: isBlinking, color1: color1, color2: color2))
        }
}
