//
//  File.swift
//  
//
//  Created by Henri Bredt on 25.02.24.
//

import SwiftUI

struct FloatingViewModifier<FloatingContent: View>: ViewModifier {
    @GestureState private var dragOffset = CGSize.zero
    @State private var storedOffset = CGSize.zero
    @ViewBuilder var floatingContent: FloatingContent

    func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
               floatingContent
                    .offset(
                        x: storedOffset.width + dragOffset.width,
                        y: storedOffset.height + dragOffset.height
                    )
                    .gesture(DragGesture()
                        .updating($dragOffset) { (value, state, _) in
                            state = value.translation
                        }
                        .onEnded { value in
                            storedOffset.width += value.translation.width
                            storedOffset.height += value.translation.height
                        }
                    )
            }
        }
    }
}

// Usage
/*
View()
.modifier(FloatingViewModifier(floatingContent: {Text("hi")}))
*/
